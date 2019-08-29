use std::fmt::{Display, Formatter, Result as FmtResult};

use super::{CratePlatform, Endianness, Env, Family, MaybeBool, Os, PointerWidth};

pub fn unescape_str<T>(s: T) -> String
where
    String: From<T>,
{
    String::from(s)
        .replace(r#"\\"#, "\\")
        .replace(r#"\""#, "\"")
}

pub trait Predicate: Display {
    /// closed world predicate
    fn test(&self, platform: &CratePlatform) -> bool;
    /// open world predicate
    fn test_open(&self, platform: &CratePlatform) -> MaybeBool;
}

pub struct Any(pub(crate) Vec<Box<dyn Predicate>>);

impl Predicate for Any {
    fn test(&self, platform: &CratePlatform) -> bool {
        self.0.iter().any(|p| p.test(platform))
    }

    fn test_open(&self, platform: &CratePlatform) -> MaybeBool {
        self.0
            .iter()
            .fold(MaybeBool::False, |maybe, p| maybe | p.test_open(platform))
    }
}

impl Display for Any {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        let inner: Vec<_> = self.0.iter().map(|p| format!("{}", p)).collect();
        let inner = inner.as_slice().join(", ");
        write!(f, "any({})", inner)
    }
}

pub struct All(pub(crate) Vec<Box<dyn Predicate>>);

impl Predicate for All {
    fn test(&self, platform: &CratePlatform) -> bool {
        self.0.iter().all(|p| p.test(platform))
    }

    fn test_open(&self, platform: &CratePlatform) -> MaybeBool {
        self.0
            .iter()
            .fold(MaybeBool::True, |maybe, p| maybe & p.test_open(platform))
    }
}

impl Display for All {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        let inner: Vec<_> = self.0.iter().map(|p| format!("{}", p)).collect();
        let inner = inner.as_slice().join(", ");
        write!(f, "all({})", inner)
    }
}

pub struct Not(pub(crate) Box<dyn Predicate>);

impl Predicate for Not {
    fn test(&self, platform: &CratePlatform) -> bool {
        !self.0.test(platform)
    }

    fn test_open(&self, platform: &CratePlatform) -> MaybeBool {
        -self.0.test_open(platform)
    }
}

impl Display for Not {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        write!(f, "not({})", self.0)
    }
}

pub enum Key {
    TargetArch(String),
    TargetOs(Os),
    TargetFamily(Family),
    TargetEnv(Env),
    TargetEndianness(Endianness),
    TargetPointerWidth(PointerWidth),
    TargetVendor(String),
    Feature(String),
    Other(String, String),
}

impl From<(String, String)> for Key {
    fn from((key, value): (String, String)) -> Self {
        use Key::*;
        match &key as &str {
            "target_arch" => TargetArch(value),
            "target_os" => TargetOs(value.into()),
            "target_family" => TargetFamily(value.into()),
            "target_env" => TargetEnv(value.into()),
            "target_endianness" => TargetEndianness(value.into()),
            "target_pointer_width" => TargetPointerWidth(value.into()),
            "target_vendor" => TargetVendor(value.into()),
            "feature" => Feature(value),
            _ => Other(key, value),
        }
    }
}

impl Display for Key {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        use Key::*;
        match self {
            TargetArch(arch) => write!(
                f,
                "target_arch = \"{}\"",
                arch.escape_default().collect::<String>()
            ),
            TargetOs(os) => write!(f, "target_os = \"{}\"", os),
            TargetFamily(family) => write!(f, "target_family = \"{}\"", family),
            TargetEnv(env) => write!(f, "target_env = \"{}\"", env),
            TargetEndianness(endianness) => write!(f, "target_endian = \"{}\"", endianness),
            TargetPointerWidth(pointer) => write!(f, "target_pointer_width = \"{}\"", pointer),
            TargetVendor(vendor) => write!(
                f,
                "target_vendor = \"{}\"",
                vendor.escape_default().collect::<String>()
            ),
            Feature(feature) => write!(
                f,
                "feature = \"{}\"",
                feature.escape_default().collect::<String>()
            ),
            Other(key, value) => write!(
                f,
                "{} = \"{}\"",
                key,
                value.escape_default().collect::<String>()
            ),
        }
    }
}

impl Predicate for Key {
    fn test(&self, platform: &CratePlatform) -> bool {
        use Key::*;
        match self {
            TargetArch(arch) => platform.arch.as_ref().map(|a| arch == a).unwrap_or(false),
            TargetOs(os) => platform.os.map(|o| o.contains(*os)).unwrap_or(false),
            TargetFamily(family) => platform
                .os
                .map(|os| match family {
                    Family::Unix => os.contains(Os::UNIX),
                    Family::Windows => os.contains(Os::WINDOWS),
                    _ => false,
                })
                .unwrap_or(false),
            TargetEnv(env) => platform.env.map(|e| env == e).unwrap_or(false),
            TargetEndianness(endianness) => platform
                .endianness
                .map(|e| endianness == e)
                .unwrap_or(false),
            TargetPointerWidth(pw) => platform.pointer_width.map(|pw_| pw == pw_).unwrap_or(false),
            TargetVendor(vendor) => platform.vendor.map(|v| vendor == v).unwrap_or(false),
            Feature(feature) => platform.has_feature(feature),
            _ => false,
        }
    }
    fn test_open(&self, platform: &CratePlatform) -> MaybeBool {
        use Key::*;
        use MaybeBool::*;
        match self {
            Feature(feature) => {
                if platform.has_feature(feature) {
                    True
                } else {
                    Maybe {
                        positive: Some(feature.to_string()).into_iter().collect(),
                        negative: Default::default(),
                    }
                }
            }
            s => s.test(platform).into(),
        }
    }
}

pub enum CfgOption {
    Windows,
    Unix,
    Test,
    Other(String),
}

impl Display for CfgOption {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        use CfgOption::*;
        match self {
            Windows => write!(f, "windows"),
            Unix => write!(f, "unix"),
            Test => write!(f, "test"),
            Other(o) => write!(f, "{}", o),
        }
    }
}

impl Predicate for CfgOption {
    fn test(&self, platform: &CratePlatform) -> bool {
        use CfgOption::*;
        match self {
            Windows => platform
                .os
                .as_ref()
                .map(|os| os.contains(Os::WINDOWS))
                .unwrap_or(false),
            Unix => platform.os.map(|os| os.contains(Os::UNIX)).unwrap_or(false),
            Test => true,
            _ => false,
        }
    }
    fn test_open(&self, platform: &CratePlatform) -> MaybeBool {
        use MaybeBool::*;
        if self.test(platform) {
            True
        } else {
            False
        }
    }
}
