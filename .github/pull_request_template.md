## Pull Requests

Many files are generated.  When you draft your changes, please separate out
commits that affect:

- Cargo.lock
- Cargo.nix
- flake.lock

Keeping these changes isolated in specific commits makes it much easier to pull
in your changes in parallel with other features.  Maintainers may harvest your
changes.  We only guarantee to preserve authorship in the git log (when we
remember to do so).

### Creating pull requests

1. Fork this repository into the personal GitHub account
2. Select the appropriate branch, release-<version> for stable changes, unstable
   for breaking changes
3. Make changes on the personal fork
4. Make a Pull Request against this repository
5. **Allow maintainers to make changes to your pull request** (there's a checkbox)
6. Once the pull request has been approved, you will be thanked and observe your
   changes applied with authorship preserved (if we remember)
