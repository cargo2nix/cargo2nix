{lib}:
with builtins; with lib;
let
  matchToken = token: input:
    assert token != "";
    let
      tokenLength = stringLength token;
    in
    if hasPrefix token input then
      {
        success = true;
        value = { type = "token"; name = token; };
        rest = removePrefix token input;
      }
    else
      {
        success = false;
        rest = input;
      };
  cons = a: b: input:
    let
      first = a input;
      second = b first.rest;
    in
      if first.success && second.success then
        {
          success = true;
          value = { type = "cons"; first = first.value; second = second.value; };
          inherit (second) rest;
        }
      else
        {
          success = false;
          rest = input;
        };
  maybe = f: input:
    let
      result = f input;
    in
      {
        success = true;
        value = {
          type = "maybe";
          value = if result.success then result.value else null;
        };
        inherit (result) rest;
      };
  either = a: b: input:
    let
      first = a input;
      second = b input;
    in
      if first.success then
        first
      else if second.success then
        second
      else
        {
          success = false;
          rest = input;
        };
  skip = a: b: input:
    let
      first = a input;
      second = b first.rest;
    in
      if first.success then
        second
      else
        {
          success = false;
          rest = input;
        };
  interspersedWith = sep: p: input:
    let
      head = p input;
      tail = skip sep (interspersedWith sep p) head.rest;
    in
      if head.success then
        {
          success = true;
          value = {
            type = "list";
            value =
              [ head.value ] ++
              optionals
                tail.success
                (assert tail.value.type == "list"; tail.value.value);
          };
          inherit (tail) rest;
        }
      else
        {
          success = false;
          rest = input;
        };
  repeat = p: input:
    let
      head = p input;
      tail = repeat p head.rest;
    in
      if head.success then
        {
          success = true;
          value = {
            type = "list";
            value = [ head.value ] ++
              optionals
                tail.success
                (assert tail.value.type == "list"; tail.value.value);
          };
          inherit (tail) rest;
        }
      else
        {
          success = false;
          rest = input;
        };

  oneOrMoreSpaces = repeat (matchToken " ");

  zeroOrMoreSpaces = maybe (repeat (matchToken " "));

  cfgPred =
    skip zeroOrMoreSpaces (either cfgAny (either cfgAll (either cfgNot (either cfgKey cfgOption))));

  cfgList = name:
    skip
      (skip zeroOrMoreSpaces (matchToken "${name}("))
      (cons
        (interspersedWith (skip zeroOrMoreSpaces (matchToken ",")) cfgPred)
        (skip zeroOrMoreSpaces (matchToken ")")));

  foldList = op: init: result:
    if result.success then
      assert result.value.type == "cons";
      assert result.value.first.type == "list";
      {
        success = true;
        value = {
          type = "**cfg";
          value = platform:
            foldr op init result.value.first.value platform;
        };
        inherit (result) rest;
      }
    else
      {
        success = false;
        inherit (result) rest;
      };

  cfgAny =
    input:
      foldList
        (a: b: platform: a.value platform || b platform)
        (_: false)
        (cfgList "any" input);

  cfgAll =
    input:
      foldList
        (a: b: platform: a.value platform && b platform)
        (_: true)
        (cfgList "all" input);

  cfgNot = input:
    let
      result =
        skip
          (matchToken "not(")
          (cons
            cfgPred
            (skip zeroOrMoreSpaces (matchToken ")")))
          input;
    in
    if result.success then
      assert result.value.type == "cons";
      assert result.value.first.type == "**cfg";
      {
        success = true;
        value = {
          type = "**cfg";
          value = platform: ! result.value.first.value platform;
        };
        inherit (result) rest;
      }
    else
      {
        success = false;
        rest = input;
      };

  ident = input:
    let
      inputLength = stringLength input;
      isIdentChar = c:
        (c >= "a" && c <= "z") ||
        (c >= "A" && c <= "Z") ||
        (c >= "0" && c <= "9") ||
        (c == "-") ||
        (c == "_");
      end =
        findFirst
          (i: ! isIdentChar (substring i 1 input))
          inputLength
          (range 0 (inputLength - 1));
      ident = substring 0 end input;
    in
    if end > 0 then
      {
        success = true;
        value = {
          type = "token";
          value = ident;
        };
        rest = removePrefix ident input;
      }
    else
      {
        success = false;
        rest = input;
      };

  stringLiteral = input:
    let
      innerString = input:
        let
          inputLength = stringLength input;
          end = findFirst (i: substring i 1 input == "\"") (-1) (range 0 (inputLength - 1));
        in
          if end >= 0 then
            {
              success = true;
              value = {
                type = "token";
                value = substring 0 end input;
              };
              rest = substring end (inputLength - end) input;
            }
          else
            {
              success = false;
              rest = input;
            };
      stringDelimiter = matchToken "\"";
      result = skip stringDelimiter (cons innerString stringDelimiter) input;
    in
      if result.success then
        {
          success = true;
          value = {
            type = "**cfg";
            value =
              assert result.value.type == "cons" && result.value.first.type == "token";
              result.value.first.value;
          };
          inherit (result) rest;
        }
      else
        {
          success = false;
          rest = input;
        };

  testOs = os: platform:
    if os == "windows" then
      platform.isWindows
    else if os == "linux" then
      platform.isLinux
    else if os == "android" then
      platform.isAndroid
    else if os == "ios" then
      platform.isiOS
    else if os == "freebsd" then
      platform.isFreeBSD
    else if os == "netbsd" then
      platform.isNetBSD
    else if os == "openbsd" then
      platform.isOpenBSD
    else if os == "macos" then
      platform.isMacOS
    else
      false;

  testOsFamily = family: platform:
    if family == "unix" then
      platform.isUnix
    else if family == "windows" then
      platform.isWindows
    else
      false;

  testEnv = env: platform:
    if env == "" || env == "gnu" then
      platform.libc == "glibc"
    else if env == "musl" then
      platform.libc == "musl"
    else if env == "msvc" then
      platform.libc == "msvcrt"
    else
      false;

  keyPredicate = key: value: platform:
    if key == "target_arch" then
      platform.parsed.cpu.name == value
    else if key == "target_feature" then
      false
    else if key == "target_os" then
      testOs value platform
    else if key == "target_family" then
      testOsFamily value platform
    else if key == "target_env" then
      testEnv value platform
    else if key == "target_endian" then
      (value == "little" && platform.isLittleEndian) ||
      (value == "big" && !platform.isLittleEndian)
    else if key == "target_pointer_width" then
      (value == "32" && platform.is32bit) ||
      (value == "64" && platform.is64bit)
    else if key == "target_vendor" then
      platform.parsed.vendor.name == value
    else
      false;

  cfgKey = input:
    let
      result =
        cons
          ident
          (skip
            (cons
              zeroOrMoreSpaces
              (cons
                (matchToken "=")
                zeroOrMoreSpaces))
            stringLiteral)
          input;
    in
    if result.success then
      {
        success = true;
        value = {
          type = "**cfg";
          value =
            assert result.value.type == "cons";
            assert result.value.first.type == "token";
            assert result.value.second.type == "**cfg";
            keyPredicate result.value.first.value result.value.second.value;
        };
        inherit (result) rest;
      }
    else
      {
        success = false;
        rest = input;
      };

  optionPredicate = option: platform:
    if option == "windows" then
      platform.isWindows
    else if option == "unix" then
      platform.isUnix
    else if option == "test" then
      true # FIXME: determine if a package can be included for tests
    else
      false;

  cfgOption = input:
    let
      result = ident input;
    in
    if result.success then
      {
        success = true;
        value = {
          type = "**cfg";
          value =
            assert result.value.type == "token";
            optionPredicate result.value.value;
        };
        inherit (result) rest;
      }
    else
      {
        success = false;
        rest = input;
      };

  cfgRoot = cfg:
    let
      result = skip (matchToken "cfg(") (cons cfgPred (skip zeroOrMoreSpaces (matchToken ")"))) cfg;
    in
    if result.success then
      assert result.value.type == "cons";
      assert result.value.first.type == "**cfg";
      result.value.first.value
    else
      platform: false;
in
cfgRoot
