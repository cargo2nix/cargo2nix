use std::{io::Read, fs::File};

use cargo2nix::{
    ast::{Generate, FmtWriter},
    codegen::generate,
};

use failure::Error;

fn main() -> Result<(), Error> {
    let mut lockfile = String::new();
    File::open("Cargo.lock")?.read_to_string(&mut lockfile)?;
    let expr = generate(&toml::from_str(&lockfile)?);
    let mut writer = FmtWriter::new(String::new());
    expr.generate_word(&mut writer)?;
    Ok(println!("{}", writer.into_inner()))
}
