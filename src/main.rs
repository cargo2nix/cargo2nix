use std::{env::current_dir, fs::File};

use cargo2nix::{
    ast::{FmtWriter, Generate, IoWriter},
    codegen::{generate, generate_builder},
    metadata::generate_lockfile,
};

use cargo::{core::Workspace, util::config::Config};
use clap::{App, Arg};
use failure::Error;
use tokio::runtime::Runtime;

fn main() -> Result<(), Error> {
    let matches = App::new("cargo2nix")
        .version("0.2.0")
        .author("Ding Xiang Fei <dingxiangfei2009@gmail.com>")
        .about("Nixify your Cargo workspace by generating Nix version pins and Nix expression stub")
        .arg(
            Arg::with_name("pin")
                .short("p")
                .long("pin")
                .value_name("CARGO2NIX_PIN")
                .help("location to write the pin file, use '-' to write to stdout")
                .default_value("deps.nix"),
        )
        .arg(
            Arg::with_name("stub")
                .short("s")
                .long("stub")
                .value_name("CARGO2NIX_STUB")
                .help("location to write the stub file, use '-' to write to stdout")
                .default_value("crate.nix"),
        )
        .get_matches();
    let pin = matches
        .value_of_os("pin")
        .expect("pin path must be supplied");
    let stub = matches
        .value_of_os("stub")
        .expect("stub path must be supplied");

    let cfg = Config::default()?;
    let cwd = current_dir()?;
    let ws = Workspace::new(&cwd.join("Cargo.toml"), &cfg)?;

    let mut runtime = Runtime::new()?;
    let (packages, roots) = generate_lockfile(&cfg, &ws)?;
    let expr = runtime.block_on(generate(packages))?;
    if pin == "-" {
        let mut writer = FmtWriter::new(String::new());
        expr.generate_word(&mut writer)?;
        println!("{}", writer.into_inner())
    } else {
        let mut writer = IoWriter::new(File::create(pin)?);
        expr.generate_word(&mut writer)?;
    }

    let expr = generate_builder(roots);
    if stub == "-" {
        let mut writer = FmtWriter::new(String::new());
        expr.generate_word(&mut writer)?;
        println!("{}", writer.into_inner())
    } else {
        let mut writer = IoWriter::new(File::create(stub)?);
        expr.generate_word(&mut writer)?;
    }
    Ok(())
}
