use std::{
    cmp::{Ordering, PartialOrd},
    collections::{BTreeMap, BTreeSet, VecDeque},
    convert::{Infallible, TryFrom},
    fmt::{Display, Formatter, Result as FmtResult},
    marker::PhantomData,
    ops::{BitAnd, BitOr, Neg},
    str::FromStr,
};

use bitflags::bitflags;
use failure::Fail;
use lazy_static::lazy_static;
use regex::Regex;
use serde::{
    de::{self, value::MapAccessDeserializer, Deserializer, MapAccess, Visitor},
    Deserialize, Serialize,
};

lazy_static! {
    static ref DEP_FEATURE: Regex =
        Regex::new(r#"([^/]+)/(.+)"#).expect("regex compilation failed");
}

pub mod cfg;
pub mod parser;

use self::cfg::unescape_str;

pub enum MaybeBool {
    True,
    False,
    Maybe {
        positive: BTreeSet<String>,
        negative: BTreeSet<String>,
    },
}

impl BitAnd for MaybeBool {
    type Output = Self;
    fn bitand(self, other: MaybeBool) -> Self {
        use MaybeBool::*;
        match (self, other) {
            (True, True) => True,
            (_, False) | (False, _) => False,
            (
                Maybe {
                    mut positive,
                    mut negative,
                },
                Maybe {
                    positive: mut positive_,
                    negative: mut negative_,
                },
            ) => {
                positive.append(&mut positive_);
                negative.append(&mut negative_);
                Maybe { positive, negative }
            }
            (Maybe { positive, negative }, _) => Maybe { positive, negative },
            (_, Maybe { positive, negative }) => Maybe { positive, negative },
        }
    }
}

impl BitOr for MaybeBool {
    type Output = Self;
    fn bitor(self, other: MaybeBool) -> Self {
        use MaybeBool::*;
        match (self, other) {
            (False, False) => False,
            (_, True) | (True, _) => True,
            (
                Maybe {
                    mut positive,
                    mut negative,
                },
                Maybe {
                    positive: mut positive_,
                    negative: mut negative_,
                },
            ) => {
                positive.append(&mut positive_);
                negative.append(&mut negative_);
                Maybe { positive, negative }
            }
            (Maybe { positive, negative }, _) => Maybe { positive, negative },
            (_, Maybe { positive, negative }) => Maybe { positive, negative },
        }
    }
}

impl Neg for MaybeBool {
    type Output = Self;
    fn neg(self) -> Self {
        use MaybeBool::*;
        match self {
            True => False,
            False => True,
            Maybe { positive, negative } => Maybe {
                positive: negative,
                negative: positive,
            },
        }
    }
}

impl From<bool> for MaybeBool {
    fn from(b: bool) -> Self {
        use MaybeBool::*;
        if b {
            True
        } else {
            False
        }
    }
}

#[derive(PartialEq, Eq)]
pub enum Endianness {
    Big,
    Little,
    Other(String),
}

impl<T: AsRef<str>> From<T> for Endianness {
    fn from(s: T) -> Self {
        use Endianness::*;
        match s.as_ref() {
            "little" => Little,
            "big" => Big,
            other => Other(unescape_str(other)),
        }
    }
}

impl Display for Endianness {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        use Endianness::*;
        match self {
            Little => write!(f, "little"),
            Big => write!(f, "big"),
            Other(other) => write!(f, "{}", other.escape_default().collect::<String>()),
        }
    }
}

#[derive(PartialEq, Eq)]
pub enum Env {
    Gnu,
    Musl,
    Msvc,
    Other(String),
}

impl<T: AsRef<str>> From<T> for Env {
    fn from(s: T) -> Self {
        use Env::*;
        match s.as_ref() {
            "" | "gnu" => Gnu,
            "musl" => Musl,
            "msvc" => Msvc,
            other => Other(unescape_str(other)),
        }
    }
}

impl Display for Env {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        use Env::*;
        match self {
            Gnu => write!(f, "gnu"),
            Musl => write!(f, "musl"),
            Msvc => write!(f, "msvc"),
            Other(other) => write!(f, "{}", other.escape_default().collect::<String>()),
        }
    }
}

#[derive(PartialEq, Eq)]
pub enum PointerWidth {
    I32,
    I64,
    Other(String),
}

impl<T: AsRef<str>> From<T> for PointerWidth {
    fn from(s: T) -> Self {
        use PointerWidth::*;
        match s.as_ref() {
            "32" => I32,
            "64" => I64,
            other => Other(unescape_str(other)),
        }
    }
}

impl Display for PointerWidth {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        use PointerWidth::*;
        match self {
            I32 => write!(f, "32"),
            I64 => write!(f, "64"),
            Other(other) => write!(f, "{}", other.escape_default().collect::<String>()),
        }
    }
}

#[derive(PartialEq, Eq)]
pub enum Family {
    Unix,
    Windows,
    Other(String),
}

impl<T: AsRef<str>> From<T> for Family {
    fn from(s: T) -> Self {
        use Family::*;
        match s.as_ref() {
            "unix" => Unix,
            "windows" => Windows,
            other => Other(unescape_str(other)),
        }
    }
}

impl Display for Family {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        use Family::*;
        match self {
            Unix => write!(f, "unix"),
            Windows => write!(f, "windows"),
            Other(other) => write!(f, "{}", other.escape_default().collect::<String>()),
        }
    }
}

bitflags! {
    pub struct Os: u16 {
        const LINUX   = 0b0100000001;
        const WINDOWS = 0b0000000010;
        const ANDROID = 0b0100000101;
        const IOS     = 0b0100001000;
        const FREEBSD = 0b0100010000;
        const NETBSD  = 0b0100100000;
        const OPENBSD = 0b0101000000;
        const MACOS   = 0b0110000000;
        const UNIX    = 0b0100000000;
        const OTHER   = 0b1000000000;
    }
}

impl<T: AsRef<str>> From<T> for Os {
    fn from(s: T) -> Self {
        match s.as_ref() {
            "linux" => Os::LINUX,
            "windows" => Os::WINDOWS,
            "android" => Os::ANDROID,
            "ios" => Os::IOS,
            "freebsd" => Os::FREEBSD,
            "netbsd" => Os::NETBSD,
            "openbsd" => Os::OPENBSD,
            "macos" => Os::MACOS,
            _ => Os::OTHER,
        }
    }
}

impl Display for Os {
    fn fmt(&self, f: &mut Formatter) -> FmtResult {
        if self.contains(Os::ANDROID) {
            write!(f, "android")
        } else if self.contains(Os::WINDOWS) {
            write!(f, "windows")
        } else if self.contains(Os::LINUX) {
            write!(f, "linux")
        } else if self.contains(Os::IOS) {
            write!(f, "ios")
        } else if self.contains(Os::MACOS) {
            write!(f, "macos")
        } else if self.contains(Os::FREEBSD) {
            write!(f, "freebsd")
        } else if self.contains(Os::NETBSD) {
            write!(f, "netbsd")
        } else {
            Ok(())
        }
    }
}

#[derive(Debug, Fail)]
pub enum ResolveError {
    #[fail(display = "parse error: {}", _0)]
    Parse(#[cause] serde_json::error::Error),
}

pub struct Platform {
    config: String,
    arch: Option<String>,
    os: Option<Os>,
    endianness: Option<Endianness>,
    env: Option<Env>,
    pointer_width: Option<PointerWidth>,
    vendor: Option<String>,
}

pub struct CratePlatform<'a> {
    pub config: &'a str,
    pub arch: Option<&'a str>,
    pub os: Option<&'a Os>,
    pub endianness: Option<&'a Endianness>,
    pub env: Option<&'a Env>,
    pub pointer_width: Option<&'a PointerWidth>,
    pub vendor: Option<&'a str>,
    pub crate_features: &'a [&'a str],
}

impl<'a> CratePlatform<'a> {
    fn with_features(platform: &'a Platform, crate_features: &'a [&'a str]) -> Self {
        let Platform {
            config,
            arch,
            os,
            endianness,
            env,
            pointer_width,
            vendor,
        } = platform;
        Self {
            config,
            arch: arch.as_ref().map(|s| s.as_str()),
            os: os.as_ref(),
            endianness: endianness.as_ref(),
            env: env.as_ref(),
            pointer_width: pointer_width.as_ref(),
            vendor: vendor.as_ref().map(|s| s.as_str()),
            crate_features,
        }
    }

    fn has_feature<S: AsRef<str>>(&self, feature: S) -> bool {
        let feature = feature.as_ref();
        self.crate_features.iter().any(|f| f == &feature)
    }
}

#[derive(Deserialize)]
pub struct RawPlatform {
    config: String,
    is32bit: bool,
    is64bit: bool,
    #[serde(rename = "isAndroid")]
    is_android: bool,
    #[serde(rename = "isBigEndian")]
    is_big_endian: bool,
    #[serde(rename = "isFreeBSD")]
    is_freebsd: bool,
    #[serde(rename = "isiOS")]
    is_ios: bool,
    #[serde(rename = "isLinux")]
    is_linux: bool,
    #[serde(rename = "isLittleEndian")]
    is_little_endian: bool,
    #[serde(rename = "isMacOS")]
    is_macos: bool,
    #[serde(rename = "isNetBSD")]
    is_netbsd: bool,
    #[serde(rename = "isOpenBSD")]
    is_openbsd: bool,
    #[serde(rename = "isUnix")]
    is_unix: bool,
    #[serde(rename = "isWindows")]
    is_windows: bool,
    #[serde(default)]
    libc: String,
    parsed: RawParsedPlatform,
}

#[derive(Deserialize)]
struct RawParsedPlatform {
    cpu: RawCpu,
    vendor: RawVendor,
}

#[derive(Deserialize)]
struct RawCpu {
    name: String,
}

#[derive(Deserialize)]
struct RawVendor {
    name: String,
}

impl TryFrom<RawPlatform> for Platform {
    type Error = ResolveError;
    fn try_from(raw: RawPlatform) -> Result<Self, Self::Error> {
        let RawPlatform {
            config,
            is32bit,
            is64bit,
            is_android,
            is_big_endian,
            is_freebsd,
            is_openbsd,
            is_ios,
            is_linux,
            is_little_endian,
            is_macos,
            is_netbsd,
            is_unix,
            is_windows,
            libc,
            parsed,
            ..
        } = raw;
        let mut os = Os::empty();
        if is_linux {
            os |= Os::LINUX;
        }
        if is_android {
            os |= Os::ANDROID;
        }
        if is_freebsd {
            os |= Os::FREEBSD;
        }
        if is_netbsd {
            os |= Os::NETBSD;
        }
        if is_macos {
            os |= Os::MACOS;
        }
        if is_windows {
            os |= Os::WINDOWS;
        }
        if is_ios {
            os |= Os::IOS;
        }
        if is_openbsd {
            os |= Os::OPENBSD;
        }
        if is_unix {
            os |= Os::UNIX;
        }
        let endianness = if is_little_endian {
            Some(Endianness::Little)
        } else if is_big_endian {
            Some(Endianness::Big)
        } else {
            None
        };
        let env = Some(match &libc as &str {
            "glibc" => Env::Gnu,
            "musl" => Env::Musl,
            "msvcrt" => Env::Msvc,
            _ => Env::Other(libc),
        });
        let arch = Some(parsed.cpu.name);
        let pointer_width = if is32bit {
            Some(PointerWidth::I32)
        } else if is64bit {
            Some(PointerWidth::I64)
        } else {
            None
        };
        let vendor = Some(parsed.vendor.name);
        Ok(Platform {
            config,
            endianness,
            env,
            arch,
            os: Some(os),
            pointer_width,
            vendor,
        })
    }
}

type FeatureMap = BTreeMap<PackageId, BTreeSet<String>>;

#[derive(Default)]
struct DependingOnState {
    depending_on: BTreeMap<PackageId, DependingOn>,
    build_depending_on: BTreeMap<PackageId, DependingOn>,
    dev_depending_on: BTreeMap<PackageId, DependingOn>,
}
#[derive(Default)]
struct DependingOn {
    build: BTreeSet<PackageId>,
    host: BTreeSet<PackageId>,
}

fn try_enable_dep(
    package_set: &BTreeMap<PackageId, Package>,
    package_id: &PackageId,
    target: TargetPlatform,
    dep_pkg_id: &PackageId,
    spec: &DepSpec,
    dep_feature: Option<&str>,
    depending_on: &mut BTreeMap<PackageId, DependingOn>,
    target_shift: impl FnOnce(TargetPlatform) -> TargetPlatform + Copy,
    req_queue: &mut VecDeque<ModifyRequest>,
) {
    use TargetPlatform::*;
    let is_proc_macro = package_set[dep_pkg_id].manifest.lib.proc_macro;
    let target_shift = |target| {
        let target = target_shift(target);
        if is_proc_macro {
            target.to_build()
        } else {
            target
        }
    };
    let propagate_features = |target, req_queue: &mut VecDeque<_>| {
        if spec.default_features {
            req_queue.push_back(ModifyRequest::EnableFeature {
                package_id: dep_pkg_id.clone(),
                target,
                feature: "default".into(),
            });
        }
        for feature in &spec.features {
            req_queue.push_back(ModifyRequest::EnableFeature {
                package_id: dep_pkg_id.clone(),
                target,
                feature: feature.clone(),
            });
        }
        if let Some(dep_feature) = dep_feature {
            req_queue.push_back(ModifyRequest::EnableFeature {
                package_id: dep_pkg_id.clone(),
                feature: dep_feature.into(),
                target,
            });
        }
    };
    let new = match target {
        Build => depending_on
            .entry(package_id.clone())
            .or_default()
            .build
            .insert(dep_pkg_id.clone()),
        Host => depending_on
            .entry(package_id.clone())
            .or_default()
            .host
            .insert(dep_pkg_id.clone()),
    };
    if new {
        let target = target_shift(target);
        req_queue.push_back(ModifyRequest::EnablePackage {
            package_id: dep_pkg_id.clone(),
            target: target,
        });
    }
    let new = match target.to_build() {
        Build => depending_on
            .entry(package_id.clone())
            .or_default()
            .build
            .insert(dep_pkg_id.clone()),
        Host => depending_on
            .entry(package_id.clone())
            .or_default()
            .host
            .insert(dep_pkg_id.clone()),
    };
    if new {
        let target = target_shift(target.to_build());
        req_queue.push_back(ModifyRequest::EnablePackage {
            package_id: dep_pkg_id.clone(),
            target,
        });
    }
    propagate_features(target_shift(target), req_queue);
    propagate_features(target_shift(target.to_build()), req_queue);
}

fn bootstrap_dep(
    package_set: &BTreeMap<PackageId, Package>,
    package_id: &PackageId,
    target: TargetPlatform,
    dep_spec: &DepSpecMap,
    may_depending_on: &BTreeMap<PackageId, BTreeMap<String, PackageId>>,
    depending_on: &mut BTreeMap<PackageId, DependingOn>,
    target_shift: impl FnOnce(TargetPlatform) -> TargetPlatform + Copy,
    req_queue: &mut VecDeque<ModifyRequest>,
) {
    for (dep, spec) in dep_spec {
        if spec.optional {
            continue;
        }
        if let Some(dep_pkg_id) = may_depending_on
            .get(package_id)
            .and_then(|p| p.get(&dep as &str))
        {
            try_enable_dep(
                package_set,
                package_id,
                target,
                dep_pkg_id,
                spec,
                None,
                depending_on,
                target_shift,
                req_queue,
            );
        }
    }
}

enum ModifyRequest {
    EnablePackage {
        package_id: PackageId,
        target: TargetPlatform,
    },
    EnableFeature {
        package_id: PackageId,
        feature: String,
        target: TargetPlatform,
    },
}

fn resolve_open(
    packages: &BTreeMap<PackageId, Package>,
    depending_on_state: &mut DependingOnState,
    feature_map: &mut FeatureMap,
    may_depending_on: &BTreeMap<PackageId, BTreeMap<String, PackageId>>,
    use_dev_deps: &BTreeSet<PackageId>,
    incomplete_resolved: &mut BTreeSet<(PackageId, TargetPlatform)>,
    complete_resolved: &BTreeSet<(PackageId, TargetPlatform)>,
    build_platform: &Platform,
    host_platform: &Platform,
    initial_requests: Vec<PackageRequest>,
) -> Result<(), ResolveError> {
    let mut req_queue: VecDeque<_> = initial_requests
        .into_iter()
        .flat_map(
            |PackageRequest {
                 package_id,
                 features,
                 target,
                 ..
             }| {
                Some(ModifyRequest::EnablePackage {
                    package_id: package_id.clone(),
                    target,
                })
                .into_iter()
                .chain(features.iter().map(|f| ModifyRequest::EnableFeature {
                    package_id: package_id.clone(),
                    feature: f.clone(),
                    target,
                }))
                .collect::<Vec<_>>()
            },
        )
        .collect();
    while let Some(req) = req_queue.pop_front() {
        match req {
            ModifyRequest::EnablePackage { package_id, target } => {
                // collect direct dependency activations
                let package = if let Some(package) = packages.get(&package_id) {
                    package
                } else {
                    continue;
                };

                let process_deps =
                    |dep_spec: &DepSpecMap,
                     depending_on_state: &mut DependingOnState,
                     req_queue: &mut VecDeque<_>| {
                        bootstrap_dep(
                            &packages,
                            &package_id,
                            target,
                            dep_spec,
                            &may_depending_on,
                            &mut depending_on_state.depending_on,
                            TargetPlatform::to_host,
                            req_queue,
                        )
                    };
                let process_build_deps =
                    |dep_spec: &DepSpecMap,
                     depending_on_state: &mut DependingOnState,
                     req_queue: &mut VecDeque<_>| {
                        bootstrap_dep(
                            &packages,
                            &package_id,
                            target,
                            dep_spec,
                            &may_depending_on,
                            &mut depending_on_state.build_depending_on,
                            TargetPlatform::to_build,
                            req_queue,
                        )
                    };
                let process_dev_deps =
                    |dep_spec: &DepSpecMap,
                     depending_on_state: &mut DependingOnState,
                     req_queue: &mut VecDeque<_>| {
                        bootstrap_dep(
                            &packages,
                            &package_id,
                            target,
                            dep_spec,
                            &may_depending_on,
                            &mut depending_on_state.dev_depending_on,
                            TargetPlatform::to_host,
                            req_queue,
                        )
                    };
                process_deps(
                    &package.manifest.dependencies,
                    depending_on_state,
                    &mut req_queue,
                );
                process_build_deps(
                    &package.manifest.build_dependencies,
                    depending_on_state,
                    &mut req_queue,
                );
                if use_dev_deps.contains(&package_id) {
                    process_dev_deps(
                        &package.manifest.dev_dependencies,
                        depending_on_state,
                        &mut req_queue,
                    );
                }
                let mut open = false;
                let features: Vec<_> = feature_map
                    .get(&package_id)
                    .iter()
                    .flat_map(|fs| fs.iter())
                    .map(|s| s.as_str())
                    .collect();
                for (target_spec, dep_spec) in &package.manifest.target {
                    use TargetPlatform::*;
                    let platform = match target {
                        Build => &build_platform,
                        Host => &host_platform,
                    };
                    if target_spec == &platform.config {
                        process_deps(&dep_spec.dependencies, depending_on_state, &mut req_queue);
                        process_build_deps(
                            &dep_spec.build_dependencies,
                            depending_on_state,
                            &mut req_queue,
                        );
                        if use_dev_deps.contains(&package_id) {
                            process_dev_deps(
                                &dep_spec.dev_dependencies,
                                depending_on_state,
                                &mut req_queue,
                            );
                        }
                    } else if let Some((_, pred)) = self::parser::parse_cfg(target_spec).ok() {
                        use MaybeBool::*;
                        let platform = CratePlatform::with_features(&platform, &features);
                        let success = match pred.test_open(&platform) {
                            True => true,
                            False => false,
                            Maybe { negative, .. } => {
                                if negative.is_empty() {
                                    pred.test(&platform)
                                } else {
                                    open = true;
                                    false
                                }
                            }
                        };
                        if success {
                            process_deps(
                                &dep_spec.dependencies,
                                depending_on_state,
                                &mut req_queue,
                            );
                            process_build_deps(
                                &dep_spec.build_dependencies,
                                depending_on_state,
                                &mut req_queue,
                            );
                            if use_dev_deps.contains(&package_id) {
                                process_dev_deps(
                                    &dep_spec.dev_dependencies,
                                    depending_on_state,
                                    &mut req_queue,
                                );
                            }
                        }
                    }
                }
                if open {
                    incomplete_resolved.insert((package_id, target));
                } else {
                    incomplete_resolved.remove(&(package_id, target));
                }
            }
            ModifyRequest::EnableFeature {
                package_id,
                target,
                feature,
            } => {
                let package = if let Some(package) = packages.get(&package_id) {
                    package
                } else {
                    continue;
                };
                // assert that `dep` points to a package with this toml name
                let (dep, dep_feature) = if let Some((Some(dep), Some(dep_feature))) =
                    DEP_FEATURE.captures(&feature).map(|c| (c.get(1), c.get(2)))
                {
                    (Some(String::from(dep.as_str())), Some(dep_feature.as_str()))
                } else if may_depending_on
                    .get(&package_id)
                    .map(|p| p.contains_key(&feature))
                    .unwrap_or(false)
                {
                    (Some(feature.clone()), None)
                } else {
                    (None, None)
                };
                let dep_pkg_id = may_depending_on
                    .get(&package_id)
                    .and_then(|p| dep.as_ref().and_then(|dep| p.get(dep)));
                // notice that features apply equally both platforms
                feature_map.entry(package_id.clone()).or_default().insert(
                    dep.as_ref()
                        .map(|d| d.clone())
                        .unwrap_or_else(|| feature.clone()),
                );
                if let Some(enabling) = package.manifest.features.get(&feature) {
                    for next_feature in enabling {
                        req_queue.push_back(ModifyRequest::EnableFeature {
                            package_id: package_id.clone(),
                            feature: next_feature.clone(),
                            target,
                        })
                    }
                }
                if let (Some(dep), Some(dep_pkg_id)) = (dep, dep_pkg_id.as_ref()) {
                    // dep points to an optional package
                    let process_dep =
                        |dep_spec: &DepSpecMap,
                         depending_on_state: &mut DependingOnState,
                         req_queue: &mut VecDeque<_>| {
                            if let Some(spec) = dep_spec.get(&dep) {
                                try_enable_dep(
                                    &packages,
                                    &package_id,
                                    target,
                                    dep_pkg_id,
                                    spec,
                                    dep_feature,
                                    &mut depending_on_state.depending_on,
                                    TargetPlatform::to_host,
                                    req_queue,
                                );
                            }
                        };
                    let process_build_dep =
                        |dep_spec: &DepSpecMap,
                         depending_on_state: &mut DependingOnState,
                         req_queue: &mut VecDeque<_>| {
                            if let Some(spec) = dep_spec.get(&dep) {
                                try_enable_dep(
                                    &packages,
                                    &package_id,
                                    target,
                                    dep_pkg_id,
                                    spec,
                                    dep_feature,
                                    &mut depending_on_state.build_depending_on,
                                    TargetPlatform::to_build,
                                    req_queue,
                                )
                            }
                        };
                    let process_dev_dep =
                        |dep_spec: &DepSpecMap,
                         depending_on_state: &mut DependingOnState,
                         req_queue: &mut VecDeque<_>| {
                            if let Some(spec) = dep_spec.get(&dep) {
                                try_enable_dep(
                                    &packages,
                                    &package_id,
                                    target,
                                    dep_pkg_id,
                                    spec,
                                    dep_feature,
                                    &mut depending_on_state.dev_depending_on,
                                    TargetPlatform::to_host,
                                    req_queue,
                                );
                            }
                        };
                    process_dep(
                        &package.manifest.dependencies,
                        depending_on_state,
                        &mut req_queue,
                    );
                    process_build_dep(
                        &package.manifest.build_dependencies,
                        depending_on_state,
                        &mut req_queue,
                    );
                    let mut open = false;
                    let features: Vec<_> = feature_map
                        .get(&package_id)
                        .iter()
                        .flat_map(|fs| fs.iter())
                        .map(|s| s.as_str())
                        .collect();
                    for (target_spec, dep_specs) in &package.manifest.target {
                        use TargetPlatform::*;
                        let platform = match target {
                            Build => &build_platform,
                            Host => &host_platform,
                        };
                        if target_spec == &platform.config {
                            process_dep(
                                &dep_specs.dependencies,
                                depending_on_state,
                                &mut req_queue,
                            );
                            process_build_dep(
                                &dep_specs.build_dependencies,
                                depending_on_state,
                                &mut req_queue,
                            );
                        } else if let Some((_, pred)) = self::parser::parse_cfg(target_spec).ok() {
                            use MaybeBool::*;
                            let platform = CratePlatform::with_features(&platform, &features);
                            let success = {
                                if complete_resolved.contains(&(package_id.clone(), target)) {
                                    pred.test(&platform)
                                } else {
                                    match pred.test_open(&platform) {
                                        True => true,
                                        False => false,
                                        Maybe { negative, .. } => {
                                            if negative.is_empty() {
                                                pred.test(&platform)
                                            } else {
                                                open = true;
                                                false
                                            }
                                        }
                                    }
                                }
                            };
                            if success {
                                process_dep(
                                    &dep_specs.dependencies,
                                    depending_on_state,
                                    &mut req_queue,
                                );
                                process_build_dep(
                                    &dep_specs.build_dependencies,
                                    depending_on_state,
                                    &mut req_queue,
                                );
                                if use_dev_deps.contains(&package_id) {
                                    process_dev_dep(
                                        &dep_specs.dev_dependencies,
                                        depending_on_state,
                                        &mut req_queue,
                                    );
                                }
                            }
                        }
                    }
                    if open {
                        incomplete_resolved.insert((package_id, target));
                    } else {
                        incomplete_resolved.remove(&(package_id, target));
                    }
                }
            }
        }
    }
    Ok(())
}

pub fn resolve(req: ResolveRequest) -> Result<ResolveResponse, ResolveError> {
    // For all crate c and d,
    // c.profile = test/bench -> c.panic = "unwind"
    // c.lib.proc_macro = true -> c.panic = "unwind"
    // c depends on d -> d.panic requests to be c.panic = c.manifest.profile.${profile}.panic or "unwind"
    let ResolveRequest {
        build_platform,
        host_platform,
        packages,
        initial_requests,
    } = req;
    let build_platform = Platform::try_from(build_platform)?;
    let host_platform = Platform::try_from(host_platform)?;
    // MayDependingOn: one-to-many binary relation on (PackageId, TomlName, PackageId)
    let mut may_depending_on: BTreeMap<PackageId, BTreeMap<String, PackageId>> = BTreeMap::new();
    let use_dev_deps: BTreeSet<_> = initial_requests
        .iter()
        .filter(|r| r.use_dev_deps)
        .map(|r| r.package_id.clone())
        .collect();
    for (package_id, package) in packages.iter() {
        let h = may_depending_on.entry(package_id.clone()).or_default();
        for Dependency {
            ref toml_names,
            package_id: dep_pkg_id,
            ..
        } in &package.dependencies
        {
            for toml_name in toml_names {
                h.insert(toml_name.clone(), dep_pkg_id.clone());
            }
        }
    }
    let may_depending_on = may_depending_on;

    // {,Build,Dev}DependingOn: one-to-many binary relation on (PackageId, PackageId)
    let mut depending_on_state: DependingOnState = Default::default();
    // Features: one-to-many binary relation on (PackageId, Feature)
    let mut features_enabled: FeatureMap = FeatureMap::new();

    let mut incomplete = Default::default();
    let mut complete = Default::default();

    resolve_open(
        &packages,
        &mut depending_on_state,
        &mut features_enabled,
        &may_depending_on,
        &use_dev_deps,
        &mut incomplete,
        &complete,
        &build_platform,
        &host_platform,
        initial_requests,
    )?;

    while !incomplete.is_empty() {
        // topological sort, to find a package without any dependent and make closed world assumption on it
        // note that only the minimal element, aka. one of the most downstream crates, is selected
        let mut visited = BTreeSet::new();
        for (package_id, target) in &incomplete {
            let mut queue = VecDeque::new();
            let target = *target;
            if visited.contains(&(package_id.clone(), target)) {
                continue;
            }
            queue.push_back((package_id.clone(), target));
            while let Some(pkg) = queue.pop_front() {
                let (package_id, target) = pkg;
                let process_deps = |package_id,
                                    target: TargetPlatform,
                                    spec,
                                    queue: &mut VecDeque<_>,
                                    visited: &mut BTreeSet<_>| {
                    for (dep, _) in spec {
                        if let Some(dep_pkg_id) =
                            may_depending_on.get(package_id).and_then(|p| p.get(dep))
                        {
                            let target = if packages[dep_pkg_id].manifest.lib.proc_macro {
                                target.to_build()
                            } else {
                                target
                            };
                            let pkg = (dep_pkg_id.clone(), target);
                            if visited.contains(&pkg) {
                                continue;
                            }
                            queue.push_back(pkg.clone());
                            visited.insert(pkg);
                        }
                    }
                };
                let process_build_deps =
                    |package_id,
                     target: TargetPlatform,
                     spec,
                     queue: &mut VecDeque<_>,
                     visited: &mut BTreeSet<_>| {
                        for (dep, _) in spec {
                            if let Some(dep_pkg_id) =
                                may_depending_on.get(package_id).and_then(|p| p.get(dep))
                            {
                                let target = target.to_build();
                                let pkg = (dep_pkg_id.clone(), target);
                                if visited.contains(&pkg) {
                                    continue;
                                }
                                queue.push_back(pkg.clone());
                                visited.insert(pkg);
                            }
                        }
                    };
                let process_dev_deps =
                    |package_id,
                     target: TargetPlatform,
                     spec,
                     queue: &mut VecDeque<_>,
                     visited: &mut BTreeSet<_>| {
                        for (dep, _) in spec {
                            if let Some(dep_pkg_id) =
                                may_depending_on.get(package_id).and_then(|p| p.get(dep))
                            {
                                let target = if packages[dep_pkg_id].manifest.lib.proc_macro {
                                    target.to_build()
                                } else {
                                    target
                                };
                                let pkg = (dep_pkg_id.clone(), target);
                                if visited.contains(&pkg) {
                                    continue;
                                }
                                queue.push_back((dep_pkg_id.clone(), target));
                                visited.insert(pkg);
                            }
                        }
                    };
                let package = &packages[&package_id];
                process_deps(
                    &package_id,
                    target,
                    &package.manifest.dependencies,
                    &mut queue,
                    &mut visited,
                );
                process_build_deps(
                    &package_id,
                    target,
                    &package.manifest.build_dependencies,
                    &mut queue,
                    &mut visited,
                );
                if use_dev_deps.contains(&package_id) {
                    process_dev_deps(
                        &package_id,
                        target,
                        &package.manifest.dev_dependencies,
                        &mut queue,
                        &mut visited,
                    );
                }
                for (_, spec) in &package.manifest.target {
                    process_deps(
                        &package_id,
                        target,
                        &spec.dependencies,
                        &mut queue,
                        &mut visited,
                    );
                    process_build_deps(
                        &package_id,
                        target,
                        &spec.build_dependencies,
                        &mut queue,
                        &mut visited,
                    );
                    if use_dev_deps.contains(&package_id) {
                        process_dev_deps(
                            &package_id,
                            target,
                            &spec.dev_dependencies,
                            &mut queue,
                            &mut visited,
                        );
                    }
                }
            }
        }
        let mut requests = vec![];
        for (package_id, target) in incomplete.iter().filter(|pkg| !visited.contains(pkg)) {
            complete.insert((package_id.clone(), *target));
            requests.push(PackageRequest {
                use_dev_deps: use_dev_deps.contains(&package_id),
                package_id: package_id.clone(),
                target: *target,
                features: vec![],
            });
        }
        resolve_open(
            &packages,
            &mut depending_on_state,
            &mut features_enabled,
            &may_depending_on,
            &use_dev_deps,
            &mut incomplete,
            &complete,
            &build_platform,
            &host_platform,
            requests,
        )?;
    }
    // the previous loop will eventually terminate, because the dependency graph is acyclic

    let transformer = |mut deps: BTreeMap<PackageId, BTreeMap<String, BTreeSet<PackageId>>>,
                       (
        package_id,
        DependingOn {
            mut build,
            mut host,
        },
    ): (PackageId, DependingOn)| {
        let entry = deps.entry(package_id).or_default();
        entry
            .entry(build_platform.config.to_string())
            .or_default()
            .append(&mut build);
        entry
            .entry(host_platform.config.to_string())
            .or_default()
            .append(&mut host);
        deps
    };
    let dependencies = depending_on_state
        .depending_on
        .into_iter()
        .fold(BTreeMap::new(), transformer);
    let build_dependencies = depending_on_state
        .build_depending_on
        .into_iter()
        .fold(BTreeMap::new(), transformer);
    let dev_dependencies = depending_on_state
        .dev_depending_on
        .into_iter()
        .fold(BTreeMap::new(), transformer);
    Ok(ResolveResponse {
        dependencies,
        build_dependencies,
        dev_dependencies,
        features: features_enabled,
    })
}

fn true_bool() -> bool {
    true
}

#[derive(PartialOrd, Ord, PartialEq, Eq, Hash, Serialize, Deserialize, Clone)]
pub struct PackageId(String);

impl AsRef<str> for PackageId {
    fn as_ref(&self) -> &str {
        &self.0
    }
}

#[derive(Deserialize)]
pub struct ResolveRequest {
    #[serde(rename = "buildPlatform")]
    build_platform: RawPlatform,
    #[serde(rename = "hostPlatform")]
    host_platform: RawPlatform,
    packages: BTreeMap<PackageId, Package>,
    #[serde(rename = "initial")]
    initial_requests: Vec<PackageRequest>,
}

#[derive(Deserialize)]
struct PackageRequest {
    #[serde(rename = "package-id")]
    package_id: PackageId,
    #[serde(default)]
    features: Vec<String>,
    #[serde(skip)]
    target: TargetPlatform,
    #[serde(default)]
    #[serde(rename = "use-dev-dependencies")]
    use_dev_deps: bool,
}

#[derive(Clone, Copy, Hash, PartialEq, Eq, Ord)]
pub enum TargetPlatform {
    Host,
    Build,
}

impl PartialOrd for TargetPlatform {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        use TargetPlatform::*;
        Some(match (self, other) {
            (Host, Build) => Ordering::Greater,
            (Build, Host) => Ordering::Less,
            _ => Ordering::Equal,
        })
    }
}

impl TargetPlatform {
    fn to_build(self) -> Self {
        use TargetPlatform::*;
        match self {
            Host => Build,
            Build => Build,
        }
    }
    fn to_host(self) -> Self {
        self
    }
}

impl Default for TargetPlatform {
    fn default() -> Self {
        TargetPlatform::Host
    }
}

#[derive(Deserialize)]
struct Package {
    dependencies: Vec<Dependency>,
    #[serde(rename = "cargo-manifest")]
    manifest: Manifest,
}

#[derive(Deserialize)]
struct Dependency {
    #[serde(rename = "package-id")]
    package_id: PackageId,
    #[serde(rename = "toml-names")]
    toml_names: Vec<String>,
}

type DepSpecMap = BTreeMap<String, DepSpec>;

#[derive(Deserialize)]
struct Manifest {
    #[serde(default)]
    lib: Lib,
    #[serde(default)]
    dependencies: DepSpecMap,
    #[serde(default)]
    #[serde(rename = "build-dependencies")]
    build_dependencies: DepSpecMap,
    #[serde(default)]
    #[serde(rename = "dev-dependencies")]
    dev_dependencies: DepSpecMap,
    #[serde(default)]
    target: BTreeMap<String, TargetSpecMap>,
    #[serde(default)]
    features: BTreeMap<String, Vec<String>>,
}

#[derive(Deserialize)]
struct TargetSpecMap {
    #[serde(default)]
    dependencies: DepSpecMap,
    #[serde(default)]
    #[serde(rename = "build-dependencies")]
    build_dependencies: DepSpecMap,
    #[serde(default)]
    #[serde(rename = "dev-dependencies")]
    dev_dependencies: DepSpecMap,
}

fn string_or_struct<'d, T, D, E>(d: D) -> Result<T, D::Error>
where
    T: Deserialize<'d> + FromStr<Err = E>,
    D: Deserializer<'d>,
    E: Display,
{
    struct StringOrStructVisitor<T, E>(PhantomData<fn() -> (T, E)>);

    impl<'d, T, E> Visitor<'d> for StringOrStructVisitor<T, E>
    where
        T: Deserialize<'d> + FromStr<Err = E>,
        E: Display,
    {
        type Value = T;

        fn expecting(&self, f: &mut Formatter) -> FmtResult {
            write!(f, "string or struct")
        }

        fn visit_str<EE: de::Error>(self, value: &str) -> Result<T, EE> {
            T::from_str(value).map_err(|e| EE::custom(e))
        }

        fn visit_map<M>(self, map: M) -> Result<T, M::Error>
        where
            M: MapAccess<'d>,
        {
            T::deserialize(MapAccessDeserializer::new(map))
        }
    }
    d.deserialize_any(StringOrStructVisitor(PhantomData))
}

#[derive(Deserialize)]
#[serde(from = "DepSpecInner")]
struct DepSpec {
    optional: bool,
    features: Vec<String>,
    default_features: bool,
}

impl From<DepSpecInner> for DepSpec {
    fn from(inner: DepSpecInner) -> Self {
        let DepSpecInner(DepSpecTry {
            optional,
            features,
            default_features,
        }) = inner;
        Self {
            optional,
            features,
            default_features,
        }
    }
}

#[derive(Deserialize)]
struct DepSpecInner(#[serde(deserialize_with = "self::string_or_struct")] DepSpecTry);

#[derive(Deserialize)]
struct DepSpecTry {
    #[serde(default)]
    optional: bool,
    #[serde(default)]
    features: Vec<String>,
    #[serde(default = "self::true_bool")]
    #[serde(rename = "default-features")]
    default_features: bool,
}

impl Default for DepSpecTry {
    fn default() -> Self {
        Self {
            optional: false,
            features: vec![],
            default_features: true,
        }
    }
}

impl FromStr for DepSpecTry {
    type Err = Infallible;
    fn from_str(_: &str) -> Result<Self, Self::Err> {
        Ok(DepSpecTry::default())
    }
}

#[derive(Deserialize, Default)]
struct Lib {
    #[serde(default)]
    #[serde(alias = "proc-macro")]
    proc_macro: bool,
}

#[derive(Serialize)]
pub struct ResolveResponse {
    dependencies: BTreeMap<PackageId, BTreeMap<String, BTreeSet<PackageId>>>,
    #[serde(rename = "buildDependencies")]
    build_dependencies: BTreeMap<PackageId, BTreeMap<String, BTreeSet<PackageId>>>,
    #[serde(rename = "devDependencies")]
    dev_dependencies: BTreeMap<PackageId, BTreeMap<String, BTreeSet<PackageId>>>,
    features: BTreeMap<PackageId, BTreeSet<String>>,
}

#[cfg(test)]
mod tests {
    use super::*;

    /// generated from
    /// builtins.toJSON {
    ///     inherit (stdenv.hostPlatform) is32bit is64bit isAarch32 isAarch64 isAndroid isArm isBigEndian isLittleEndian isBSD isDarwin isFreeBSD isNetBSD isOpenBSD isiOS isLinux isMacOS isMips isUnix isWindows config libc;
    ///     parsed = {
    ///         cpu = {
    ///             inherit (stdenv.hostPlatform.parsed.cpu) name;
    ///         };
    ///         vendor = {
    ///             inherit (stdenv.hostPlatform.parsed.vendor) name;
    ///         };
    ///     };
    /// }
    #[test]
    fn deserialize_works() {
        let input = "{\"config\":\"x86_64-unknown-linux-gnu\",\"is32bit\":false,\"is64bit\":true,\"isAarch32\":false,\"isAarch64\":false,\"isAndroid\":false,\"isArm\":false,\"isBSD\":false,\"isBigEndian\":false,\"isDarwin\":false,\"isFreeBSD\":false,\"isLinux\":true,\"isLittleEndian\":true,\"isMacOS\":false,\"isMips\":false,\"isNetBSD\":false,\"isOpenBSD\":false,\"isUnix\":true,\"isWindows\":false,\"isiOS\":false,\"parsed\":{\"cpu\":{\"name\":\"x86_64\"},\"vendor\":{\"name\":\"unknown\"}}}";
        let raw: RawPlatform = serde_json::from_str(input).unwrap();
    }
}
