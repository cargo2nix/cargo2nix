use std::env::current_dir;

use cargo2nix::{
    ast::{FmtWriter, Generate},
    codegen::generate,
    metadata::generate_lockfile,
};

use cargo::{core::Workspace, util::config::Config};
use failure::Error;
use tokio::runtime::Runtime;

fn main() -> Result<(), Error> {
    let cfg = Config::default()?;
    let cwd = current_dir()?;
    let ws = Workspace::new(&cwd.join("Cargo.toml"), &cfg)?;

    let mut runtime = Runtime::new()?;
    let expr = runtime.block_on(generate(generate_lockfile(&cfg, &ws)?))?;
    let mut writer = FmtWriter::new(String::new());
    expr.generate_word(&mut writer)?;
    Ok(println!("{}", writer.into_inner()))
}
