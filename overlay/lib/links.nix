tryLinks: pkgs:
    # Try to conver the [package] links attribute to the appopriate nixpkg.
    # Usually the links attribute will align with a nixpkg name such as "git2"
    # -> pkgs.libgit2.  Other packages (espeically those with both a program and
    # a library output) will not follow this naive pattern.  Provide overrides
    # as necssary.
    let
      linkOverrides = {
        curl = [ pkgs.curl.dev ];
        z = [ pkgs.zlib.dev ];
        # openssl = [ joinOpenssl ];
      };
      in if
        linkOverrides ? tryLinks
      then
        linkOverrides.${tryLinks}
      else
        let
          guessLib = "lib${tryLinks}";
        in
          if
            pkgs ? guessLib
          then
            pkgs.${guessLib}
          else
            [ ]
