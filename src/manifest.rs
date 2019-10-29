use toml::{value::Table, Value};

use serde::Deserialize;

pub fn extract_basic(manifest_contents: &[u8]) -> Value {
    if let Ok(Value::Table(tbl)) = toml::from_slice(manifest_contents) {
        Value::Table(
            tbl.into_iter()
                .filter(|(k, _)| {
                    k == "package"
                        || k == "lib"
                        || k == "bin"
                        || k == "bench"
                        || k == "test"
                        || k == "example"
                })
                .collect(),
        )
    } else {
        Value::Table(Table::new())
    }
}

pub fn extract_profiles(manifest_contents: &[u8]) -> Table {
    #[derive(Debug, Deserialize)]
    struct Manifest {
        pub profile: Option<Table>,
    }

    toml::from_slice::<Manifest>(manifest_contents)
        .ok()
        .and_then(|m| m.profile)
        .unwrap_or_default()
}
