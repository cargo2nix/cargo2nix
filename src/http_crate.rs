use std::{io, process};

use futures::{self, Future};
use tokio_process::CommandExt;

#[derive(Clone, Debug)]
pub struct CrateSha256(String);

#[derive(Debug, Fail, From)]
pub enum CrateShaError {
    #[fail(display = "nix-prefetch-url failed: {}\n{}", _0, _1)]
    NixPrefetchUrlFailed(String, String),
    #[fail(display = "io error: {}", _0)]
    IoError(#[cause] io::Error),
}

#[derive(Clone, Debug)]
pub struct CratesIoCrate {
    name: String,
    version: String,
}

impl CratesIoCrate {
    pub fn new(name: String, version: String) -> Self {
        Self { name, version }
    }

    pub fn prefetch(self) -> impl Future<Item = CrateSha256, Error = CrateShaError> {
        let Self { name, version } = self;
        process::Command::new("nix-prefetch-url")
            .arg("--type")
            .arg("sha256")
            .arg("--unpack")
            .arg(format!(
                "https://crates.io/api/v1/crates/{}/{}/download",
                name, version
            ))
            .output_async()
            .map_err(|e| e.into())
            .and_then(|o| {
                if o.status.success() {
                    let buf = String::from_utf8(o.stdout).expect("hash is not a string");
                    Ok(CrateSha256(buf.trim().to_string()))
                } else {
                    let buf = String::from_utf8(o.stdout).expect("output is not a string");
                    let err_buf = String::from_utf8(o.stderr).expect("error is not a string");
                    Err(CrateShaError::NixPrefetchUrlFailed(buf, err_buf))
                }
            })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use tokio::runtime::Runtime;

    #[test]
    #[ignore]
    fn test_prefetch() {
        let mut runtime = Runtime::new().expect("unable to create runtime");
        let crate_to_fetch = CratesIoCrate::new("futures".to_string(), "0.1.27".to_string());
        let prefetch_future = crate_to_fetch.prefetch();
        let result = runtime
            .block_on(prefetch_future)
            .expect("nix-prefetch-url command failed");
        assert_eq!(
            result.0,
            "1rq2znb567a75rgms1b1mws19saf8107clns1vgrk6j94cr7mc45".to_string()
        );
    }
}
