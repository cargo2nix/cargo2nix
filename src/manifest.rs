use toml::value::Table;

use serde::Deserialize;

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
