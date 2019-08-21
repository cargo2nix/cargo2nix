use nom::{
    branch::alt,
    bytes::complete::{escaped, tag},
    character::complete::{alphanumeric1, char, multispace0, none_of, one_of},
    combinator::{all_consuming, map, opt as opt_combinator, recognize},
    multi::{many1, separated_nonempty_list},
    sequence::{preceded, separated_pair, terminated},
};

use super::cfg::{All, Any, CfgOption, Key, Not, Predicate};

pub type IResult<'a, O> = nom::IResult<&'a str, O>;

pub fn any(input: &str) -> IResult<Any> {
    map(
        preceded(
            multispace0,
            preceded(
                tag("any("),
                terminated(list, preceded(multispace0, char(')'))),
            ),
        ),
        Any,
    )(input)
}

fn list(input: &str) -> IResult<Vec<Box<dyn Predicate>>> {
    separated_nonempty_list(
        preceded(multispace0, terminated(char(','), multispace0)),
        predicate,
    )(input)
}

pub fn all(input: &str) -> IResult<All> {
    map(
        preceded(
            multispace0,
            preceded(
                tag("all("),
                terminated(list, preceded(multispace0, char(')'))),
            ),
        ),
        All,
    )(input)
}

pub fn not(input: &str) -> IResult<Not> {
    map(
        preceded(
            multispace0,
            preceded(
                tag("not("),
                terminated(predicate, preceded(multispace0, char(')'))),
            ),
        ),
        Not,
    )(input)
}

pub fn value(input: &str) -> IResult<String> {
    let body = opt_combinator(escaped(none_of(r#""\"#), '\\', one_of(r#""\"#)));
    preceded(
        char('"'),
        map(terminated(recognize(body), char('"')), |s| {
            String::from(s)
                .replace(r#"\\"#, "\\")
                .replace(r#"\""#, "\"")
        }),
    )(input)
}

pub fn ident(input: &str) -> IResult<String> {
    map(
        recognize(many1(alt((alphanumeric1, tag("-"), tag("_"))))),
        String::from,
    )(input)
}

pub fn key(input: &str) -> IResult<Key> {
    map(
        preceded(
            multispace0,
            separated_pair(
                ident,
                preceded(multispace0, terminated(char('='), multispace0)),
                value,
            ),
        ),
        Key::from,
    )(input)
}

pub fn opt(input: &str) -> IResult<CfgOption> {
    map(ident, |o| {
        use CfgOption::*;
        match &o as &str {
            "windows" => Windows,
            "unix" => Unix,
            "test" => Test,
            _ => Other(o),
        }
    })(input)
}

pub fn predicate(input: &str) -> IResult<Box<dyn Predicate>> {
    preceded(
        multispace0,
        alt((
            map(not, |p| Box::new(p) as Box<dyn Predicate>),
            map(any, |p| Box::new(p) as Box<dyn Predicate>),
            map(all, |p| Box::new(p) as Box<dyn Predicate>),
            map(key, |p| Box::new(p) as Box<dyn Predicate>),
            map(opt, |p| Box::new(p) as Box<dyn Predicate>),
        )),
    )(input)
}

pub fn parse_cfg(input: &str) -> IResult<Box<dyn Predicate>> {
    all_consuming(preceded(
        tag("cfg("),
        terminated(
            predicate,
            preceded(multispace0, terminated(tag(")"), multispace0)),
        ),
    ))(input)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let input =
            r#"cfg( any( unix, target_os = "linux", all( windows, target_env = "msvc" ) ) )"#;
        let (_, val) = parse_cfg(input).unwrap();
        assert_eq!(
            r#"any(unix, target_os = "linux", all(windows, target_env = "msvc"))"#,
            format!("{}", val)
        );
        let input =
            "cfg(not(any(target_os = \"windows\", target_os = \"macos\", target_os = \"ios\")))";
        let (_, val) = parse_cfg(input).unwrap();
        assert_eq!(
            r#"not(any(target_os = "windows", target_os = "macos", target_os = "ios"))"#,
            format!("{}", val)
        );

        let input = "cfg(target_os = \"redox\")";
        let (_, val) = parse_cfg(input).unwrap();
        assert_eq!(r#"target_os = """#, format!("{}", val));
    }
}
