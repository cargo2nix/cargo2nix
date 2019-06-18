//! A subset of Nix context-free grammar for expression generation
pub trait Write {
    type Error;
    fn indent(&mut self, offset: isize);
    fn new_line(&mut self) -> Result<(), Self::Error>;
    fn write_char(&mut self, c: char) -> Result<(), Self::Error>;
    fn write_str(&mut self, s: &str) -> Result<(), Self::Error>;
}

pub struct FmtWriter<W> {
    inner: W,
    indent_level: usize,
}

impl<W: std::fmt::Write> FmtWriter<W> {
    pub fn new(inner: W) -> Self {
        Self {
            inner,
            indent_level: 0,
        }
    }
    pub fn into_inner(self) -> W {
        self.inner
    }
}

impl<W: std::fmt::Write> Write for FmtWriter<W> {
    type Error = std::fmt::Error;
    fn indent(&mut self, offset: isize) {
        let new_indent_level = self.indent_level as isize + offset;
        assert!(new_indent_level >= 0);
        self.indent_level = new_indent_level as usize;
    }
    fn new_line(&mut self) -> Result<(), Self::Error> {
        self.inner.write_char('\n')?;
        let indent: String = std::iter::repeat(' ').take(self.indent_level).collect();
        self.inner.write_str(&indent)
    }
    fn write_char(&mut self, c: char) -> Result<(), Self::Error> {
        self.inner.write_char(c)
    }
    fn write_str(&mut self, s: &str) -> Result<(), Self::Error> {
        self.inner.write_str(s)
    }
}

pub struct IoWriter<W> {
    inner: W,
    indent_level: usize,
}

impl<W> IoWriter<W> {
    pub fn new(writer: W) -> Self {
        Self {
            inner: writer,
            indent_level: 0,
        }
    }
}

impl<W: std::io::Write> Write for IoWriter<W> {
    type Error = std::io::Error;
    fn indent(&mut self, offset: isize) {
        let new_indent_level = self.indent_level as isize + offset;
        assert!(new_indent_level >= 0);
        self.indent_level = new_indent_level as usize;
    }
    fn new_line(&mut self) -> Result<(), Self::Error> {
        let indent: String = std::iter::once('\n')
            .chain(std::iter::repeat(' ').take(self.indent_level))
            .collect();
        self.inner.write(indent.as_bytes())?;
        Ok(())
    }
    fn write_char(&mut self, c: char) -> Result<(), Self::Error> {
        self.inner.write(c.to_string().as_bytes())?;
        Ok(())
    }
    fn write_str(&mut self, s: &str) -> Result<(), Self::Error> {
        self.inner.write(s.as_bytes())?;
        Ok(())
    }
}

pub trait Generate {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error>;
}

#[derive(Clone)]
pub struct App(pub Box<Expr>, pub Box<Expr>);

impl Generate for App {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        use Expr::*;
        let needs_quote = match *self.0 {
            App(_) | Lam(_) | Ident(_) | Projection(_) => false,
            _ => true,
        };
        if needs_quote {
            writer.write_char('(')?;
        }
        self.0.generate_word(writer)?;
        if needs_quote {
            writer.write_char(')')?;
        }
        writer.write_char(' ')?;
        let needs_quote = match *self.0 {
            App(_) | Lam(_) | Ident(_) | Projection(_) => false,
            _ => true,
        };
        if needs_quote {
            writer.write_char('(')?;
        }
        self.1.generate_word(writer)?;
        if needs_quote {
            writer.write_char(')')?;
        }
        Ok(())
    }
}

#[macro_export]
macro_rules! app {
    ($f:expr, $a: expr) => {{
        $crate::ast::Expr::App($crate::ast::App(
            ::std::boxed::Box::new($f),
            ::std::boxed::Box::new($a),
        ))
    }};
}

#[derive(Clone)]
pub enum LamArg {
    Symbolic(Ident),
    Formal(FormalArg),
}

impl Generate for LamArg {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        use LamArg::*;
        match *self {
            Symbolic(ref ident) => ident.generate_word(writer),
            Formal(ref formal) => formal.generate_word(writer),
        }
    }
}

#[derive(Clone)]
pub struct Lam {
    pub arg: LamArg,
    pub body: Box<Expr>,
}

#[macro_export]
#[doc(hidden)]
macro_rules! symbolic_arg {
    ($arg:expr) => {{
        $crate::ast::LamArg::Symbolic($arg.clone())
    }};
}

#[macro_export]
macro_rules! lambda {
    (symbolic $arg:expr => $body:expr) => {
        $crate::ast::Lam {
            arg: $crate::symbolic_arg!($arg),
            body: $body,
        }
    };
    (formal $arg:expr => $body:expr) => {
        $crate::ast::Lam {
            arg: $crate::ast::LamArg::Formal($arg),
            body: $body,
        }
    };
}

impl Generate for Lam {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        writer.write_char('(')?;
        self.arg.generate_word(writer)?;
        writer.write_char(':')?;
        writer.indent(2);
        writer.new_line()?;
        self.body.generate_word(writer)?;
        writer.indent(-2);
        writer.write_char(')')
    }
}

#[derive(Clone, Ord, PartialOrd, PartialEq, Eq)]
pub struct Ident(String);

impl Ident {
    pub fn new<T: AsRef<str>>(name: T) -> Self {
        if name.as_ref().contains(NEED_QUOTE) {
            panic!("identifier contains illegal characters, and this is a logical error if you are generating Nix expression mechanically")
        }
        Self(name.as_ref().to_string())
    }
    pub fn into_inner(self) -> String {
        self.0
    }
}

#[macro_use]
macro_rules! ident {
    ($name:expr) => {
        $crate::ast::Ident::new($name)
    };
}

impl Ident {
    pub fn to_key(&self) -> Key {
        Key::Key {
            key: self.0.clone(),
        }
    }
}

impl Generate for Ident {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        writer.write_str(&self.0)
    }
}

#[derive(Clone)]
pub struct FormalArg {
    pub args: Vec<(Ident, Option<Expr>)>,
    pub ignore_extra: bool,
    pub reference: Option<Ident>,
}

impl Generate for FormalArg {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        if let Some(ref reference) = self.reference {
            reference.generate_word(writer)?;
            writer.write_char('@')?;
        }
        writer.write_char('{')?;
        writer.indent(2);
        let mut first = true;
        for &(ref name, ref default) in self.args.iter() {
            writer.new_line()?;
            if first {
                first = false;
                writer.write_str("  ")?;
            } else {
                writer.write_str(", ")?;
            }
            name.generate_word(writer)?;
            if let Some(ref default) = *default {
                writer.write_str(" ? ")?;
                default.generate_word(writer)?;
            }
        }
        if self.ignore_extra {
            writer.new_line()?;
            if !first {
                writer.write_str(", ")?;
            }
            writer.write_str("...")?;
        }
        writer.indent(-2);
        writer.new_line()?;
        writer.write_char('}')
    }
}

#[macro_export]
macro_rules! formal_arg {
    ( $ident:tt @ { $($arg:tt)+ }) => {
        $crate::formal_arg!({ $($arg)+ } @ $ident)
    };
    ( { $($arg:tt)+ } @ $ident:expr) => {
        {
            #[allow(unused_mut, unused_assignments)]
            let mut args = vec![];
            #[allow(unused_mut, unused_assignments, unused_extra)]
            let mut ignore_extra = false;
            $crate::cons_formal_arg!(args, ignore_extra, $($arg)+);
            $crate::ast::FormalArg {
                args,
                ignore_extra,
                reference: Some($ident),
            }
        }
    };
    ( { $($arg:tt)+ } ) => {
        {
            let mut args = vec![];
            #[allow(unused_assignments, unused_mut)]
            let mut ignore_extra = false;
            $crate::cons_formal_arg!(args, ignore_extra, $($arg)+);
            $crate::ast::FormalArg {
                args,
                ignore_extra,
                reference: None,
            }
        }
    }
}

#[doc(hidden)]
#[macro_export]
macro_rules! cons_formal_arg {
    ($args:ident, $ignore_extra:ident, ...) => {
        {
            $ignore_extra = true;
        }
    };
    ($args:ident, $ignore_extra:ident, $formal_arg_name:expr) => {
        cons_formal_arg!($args, $ignore_extra, $formal_arg_name,)
    };
    ($args:ident, $ignore_extra:ident, $formal_arg_name:expr, ) => {
        {
            $args.push(($formal_arg_name, None));
        }
    };
    (
        $args:ident,
        $ignore_extra:ident,
        $formal_arg_name:expr ;? $formal_arg_default:expr
    ) => {
        cons_formal_arg!($args, $ignore_extra, $formal_arg_name ;? $formal_arg_default, );
    };
    (
        $args:ident,
        $ignore_extra:ident,
        $formal_arg_name:expr ;? $formal_arg_default:expr,
    ) => {
        {
            $args.push(($formal_arg_name, Some($formal_arg_default)));
        }
    };
    ($args:ident, $ignore_extra:ident, $formal_arg_name:expr, $($rest_arg:tt)+) => {
        {
            {
                $args.push(($formal_arg_name, None));
            }
            cons_formal_arg!($args, $ignore_extra, $($rest_arg)+)
        }
    };
    (
        $args:ident,
        $ignore_extra:ident,
        $formal_arg_name:expr ;? $formal_arg_default:expr,
        $($rest_arg:tt)+
    ) => {
        {
            {
                $args.push(($formal_arg_name, Some($formal_arg_default)));
            }
            cons_formal_arg!($args, $ignore_extra, $($rest_arg)+)
        }
    }
}

const NEED_QUOTE: &[char] = &[' ', '.', '\n', '\r', '\t', '\"', '\\', '(', ')', '='];

const QUOTE_MAP: &[(char, &str)] = &[
    ('\\', "\\\\"),
    ('\"', "\\\""),
    ('\n', "\\n"),
    ('\r', "\\r"),
    ('\t', "\\t"),
];

#[derive(Clone)]
pub enum Key {
    Key { key: String },
    Expr(Box<Expr>),
}

fn write_quoted_str<W: Write>(s: &str, writer: &mut W) -> Result<(), <W as Write>::Error> {
    writer.write_char('"')?;
    for c in s.chars() {
        match QUOTE_MAP.iter().find(|&(c_, _)| c == *c_) {
            Some((_, s)) => writer.write_str(s)?,
            None => writer.write_char(c)?,
        }
    }
    writer.write_char('"')
}

impl Generate for Key {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        match self {
            Key::Key { ref key } => {
                if key.contains(NEED_QUOTE) {
                    write_quoted_str(key, writer)
                } else {
                    writer.write_str(key)
                }
            }
            Key::Expr(ref expr) => {
                writer.write_str("${")?;
                expr.generate_word(writer)?;
                writer.write_char('}')
            }
        }
    }
}

#[macro_export]
macro_rules! key {
    ($key:expr) => {
        $crate::ast::Key::Key {
            key: $key.to_string(),
        }
    };
}

/// AttrsPath does not contain all possible Nix attrset keys
/// but it contains constant keys and quoted keys without
/// interpolation.
/// This should covers enough uses cases in mechanical
/// Nix expression generation
#[derive(Clone)]
pub struct AttrsPath(pub Vec<Key>);

impl Generate for AttrsPath {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        let mut first = true;
        for key in self.0.iter() {
            if first {
                key.generate_word(writer)?;
                first = false;
            } else {
                writer.write_char('.')?;
                key.generate_word(writer)?;
            }
        }
        Ok(())
    }
}

#[macro_export]
macro_rules! attrs_path {
    (@path $keys:ident, $key:expr) => {
        $crate::attrs_path!(@path $keys, $key,)
    };
    (@path $keys:ident, $key:expr,) => {
        {
            $keys.push($key);
            $crate::ast::AttrsPath($keys)
        }
    };
    (@path $keys:ident, $key:expr, $($rest:tt)*) => {
        {
            $keys.push($key);
            $crate::attrs_path!(@path $keys, $($rest)*)
        }
    };
    ($($key:tt)+) => {
        {
            let mut keys = Vec::new();
            $crate::attrs_path!(@path keys, $($key)+)
        }
    }
}

#[derive(Clone)]
pub struct AttrSet {
    pub recursive: bool,
    pub attrs: Vec<(AttrsPath, Expr)>,
}

impl Generate for AttrSet {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        if self.recursive {
            writer.write_str("rec ")?;
        }
        writer.write_char('{')?;
        writer.indent(2);
        for (key, value) in self.attrs.iter() {
            writer.new_line()?;
            key.generate_word(writer)?;
            writer.write_str(" = ")?;
            value.generate_word(writer)?;
            writer.write_char(';')?;
        }
        writer.indent(-2);
        writer.new_line()?;
        writer.write_char('}')
    }
}

#[macro_export]
macro_rules! attrs {
    (@rec $attrs:ident, ) => {
        $crate::ast::Expr::AttrSet(
            $crate::ast::AttrSet {
                recursive: true,
                attrs: $attrs,
            }
        )
    };
    (@nonrec $attrs:ident, ) => {
        $crate::ast::Expr::AttrSet(
            $crate::ast::AttrSet {
                recursive: false,
                attrs: $attrs,
            }
        )
    };
    (@rec $attrs:ident, $key:expr => $val:expr; $($item:tt)*) => {
        {
            $attrs.push(($key, $val));
            $crate::attrs!(@rec $attrs, $($item)*)
        }
    };
    (@nonrec $attrs:ident, $key:expr => $val:expr; $($item:tt)*) => {
        {
            $attrs.push(($key, $val));
            $crate::attrs!(@nonrec $attrs, $($item)*)
        }
    };
    ({ $($item:tt)* }) => {
        {
            #[allow(unused_mut)]
            let mut attrs = vec![];
            $crate::attrs!(@nonrec attrs, $($item)*)
        }
    };
    (rec { $($item:tt)* }) => {
        {
            #[allow(unused_mut)]
            let mut attrs = vec![];
            $crate::attrs!(@rec attrs, $($item)*)
        }
    }
}

#[derive(Clone)]
pub struct Projection {
    pub record: Box<Expr>,
    pub key: Key,
}

impl Generate for Projection {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        use Expr::*;
        let needs_quote = match *self.record {
            Ident(_) | AttrSet(_) | Projection(_) => false,
            _ => true,
        };
        if needs_quote {
            writer.write_char('(')?;
        }
        self.record.generate_word(writer)?;
        if needs_quote {
            writer.write_char(')')?;
        }
        writer.write_char('.')?;
        self.key.generate_word(writer)?;
        Ok(())
    }
}

#[macro_export]
macro_rules! proj {
    ($record:expr, $key:expr) => {
        $crate::proj!($record, $key, )
    };
    ($record:expr, $key:expr, ) => {
        $crate::ast::Expr::Projection(
            $crate::ast::Projection {
                record: ::std::boxed::Box::new($record),
                key: $key,
            })
    };
    ($record:expr, $key:expr, $($rest:tt)*) => {
        $crate::proj!(
            $crate::proj!($record, $key),
            $($rest)*
        )
    };
}

#[derive(Clone)]
pub struct List(pub Vec<Expr>);

#[macro_export]
macro_rules! list {
    ($($item:expr),+) => {
        {
            #[allow(unused_mut)]
            let mut items = vec![];
            $(
                items.push($item.clone());
            )+;
            ::std::boxed::Box::new($crate::ast::List(items))
        }
    };
}

impl Generate for List {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        writer.write_char('[')?;
        writer.indent(2);
        for expr in self.0.iter() {
            writer.new_line()?;
            use Expr::*;
            let needs_quote = match *expr {
                AttrSet(_) | Ident(_) | List(_) | NixString(_) | Projection(_) | ConstNum(_) => {
                    false
                }
                _ => true,
            };
            if needs_quote {
                writer.write_char('(')?;
            }
            expr.generate_word(writer)?;
            if needs_quote {
                writer.write_char(')')?;
            }
        }
        writer.indent(-2);
        writer.new_line()?;
        writer.write_char(']')
    }
}

#[derive(Clone)]
pub struct NixString(pub String);

impl NixString {
    pub fn new<S: AsRef<str>>(s: S) -> Self {
        Self(s.as_ref().to_string())
    }
}

impl Generate for NixString {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        write_quoted_str(&self.0, writer)
    }
}

#[macro_export]
macro_rules! nix_string {
    ($val:expr) => {
        $crate::ast::Expr::NixString($crate::ast::NixString::new($val))
    };
}

#[derive(Clone)]
pub enum ConstNum {
    Signed(i64),
    Unsigned(u64),
    Float(f64),
}

impl Generate for ConstNum {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        writer.write_str(
            match self {
                ConstNum::Signed(val) => format!("{}", val),
                ConstNum::Unsigned(val) => format!("{}", val),
                ConstNum::Float(val) => format!("{}", val),
            }
            .as_str(),
        )
    }
}

#[derive(Clone)]
pub struct Optional(pub Option<Box<Expr>>);

impl Generate for Optional {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        match &self.0 {
            Some(expr) => expr.generate_word(writer),
            None => writer.write_str("null"),
        }
    }
}

#[derive(Clone)]
pub struct Let {
    pub bindings: Vec<(Ident, Expr)>,
    pub body: Box<Expr>,
}

#[macro_export]
macro_rules! letin {
    (let $($t:tt)+) => {
        {
            #[allow(unused_mut)]
            let mut bindings = vec![];
            $crate::letin!(@let(bindings) $($t)+)
        }
    };
    (@let($bindings:ident) inherit ($rec:expr) $var:expr; $($t:tt)+) => {
        {
            {
                $bindings.push(($var.clone(), $crate::ast::Projection {
                    record: Box::new($rec),
                    key: $var.clone().to_key(),
                }.into()));
            }
            $crate::letin!(@let($bindings) $($t)+)
        }
    };
    (@let($bindings:ident) inherit $var:expr; $($t:tt)+) => {
        {
            {
                $bindings.push(($var.clone(), $var.clone().into()));
            }
            $crate::letin!(@let($bindings) $($t)+)
        }
    };
    (@let($bindings:ident) $var:expr => $val:expr; $($t:tt)+) => {
        {
            {
                $bindings.push(($var.clone(), $val.clone()));
            }
            $crate::letin!(@let($bindings) $($t)+)
        }
    };
    (@let($bindings:ident) in $body:expr) => {
        {
            $crate::ast::Let {
                bindings: $bindings,
                body: ::std::boxed::Box::new($body),
            }
        }
    }
}

impl Generate for Let {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        writer.write_str("let")?;
        writer.indent(2);
        for (var, val) in self.bindings.iter() {
            writer.new_line()?;
            match val {
                Expr::Ident(Ident(ref ident)) if &var.0 == ident => {
                    writer.write_str("inherit ")?;
                    writer.write_str(ident)?;
                }
                Expr::Projection(Projection {
                    ref record,
                    key: Key::Key { ref key },
                }) if &var.0 == key => {
                    writer.write_str("inherit (")?;
                    record.generate_word(writer)?;
                    writer.write_str(") ")?;
                    writer.write_str(key)?;
                }
                _ => {
                    var.generate_word(writer)?;
                    writer.write_str(" = ")?;
                    val.generate_word(writer)?;
                }
            }
            writer.write_char(';')?;
        }
        writer.indent(-2);
        writer.new_line()?;
        writer.write_str("in")?;
        writer.new_line()?;
        self.body.generate_word(writer)
    }
}

#[derive(Clone)]
pub struct IfElse {
    pub condition: Box<Expr>,
    pub consequent: Box<Expr>,
    pub alternative: Box<Expr>,
}

impl Generate for IfElse {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        writer.write_str("if ")?;
        self.condition.generate_word(writer)?;
        writer.write_str(" then")?;
        writer.indent(2);
        writer.new_line()?;
        self.consequent.generate_word(writer)?;
        writer.indent(-2);
        writer.new_line()?;
        writer.write_str("else")?;
        writer.indent(2);
        writer.new_line()?;
        self.alternative.generate_word(writer)?;
        writer.indent(-2);
        Ok(())
    }
}

#[macro_export]
macro_rules! ifelse {
    ($cond:expr, $cons:expr, $alt:expr) => {
        $crate::ast::IfElse {
            condition: Box::new($cond),
            consequent: Box::new($cons),
            alternative: Box::new($alt),
        }
    };
}

#[derive(Clone)]
pub struct Eq {
    pub one: Box<Expr>,
    pub another: Box<Expr>,
}

impl Generate for Eq {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        self.one.generate_word(writer)?;
        writer.write_str(" == ")?;
        self.another.generate_word(writer)
    }
}

#[derive(Clone)]
pub enum Expr {
    App(App),
    AttrSet(AttrSet),
    Ident(Ident),
    Lam(Lam),
    List(List),
    NixString(NixString),
    Projection(Projection),
    ConstNum(ConstNum),
    Optional(Optional),
    Let(Let),
    IfElse(IfElse),
    Eq(Eq),
}

impl From<App> for Expr {
    fn from(app: App) -> Self {
        Expr::App(app)
    }
}

impl From<AttrSet> for Expr {
    fn from(attrs: AttrSet) -> Self {
        Expr::AttrSet(attrs)
    }
}

impl From<Ident> for Expr {
    fn from(ident: Ident) -> Self {
        Expr::Ident(ident)
    }
}

impl From<Lam> for Expr {
    fn from(lam: Lam) -> Self {
        Expr::Lam(lam)
    }
}

impl From<List> for Expr {
    fn from(list: List) -> Self {
        Expr::List(list)
    }
}

impl From<NixString> for Expr {
    fn from(string: NixString) -> Self {
        Expr::NixString(string)
    }
}

impl From<Projection> for Expr {
    fn from(proj: Projection) -> Self {
        Expr::Projection(proj)
    }
}

impl From<ConstNum> for Expr {
    fn from(num: ConstNum) -> Self {
        Expr::ConstNum(num)
    }
}

impl From<Let> for Expr {
    fn from(r#let: Let) -> Self {
        Expr::Let(r#let)
    }
}

impl From<IfElse> for Expr {
    fn from(ifelse: IfElse) -> Self {
        Expr::IfElse(ifelse)
    }
}

impl From<Eq> for Expr {
    fn from(eq: Eq) -> Self {
        Expr::Eq(eq)
    }
}

impl Generate for Expr {
    fn generate_word<W: Write>(&self, writer: &mut W) -> Result<(), <W as Write>::Error> {
        use Expr::*;
        match *self {
            App(ref app) => app.generate_word(writer),
            AttrSet(ref attrs) => attrs.generate_word(writer),
            Ident(ref ident) => ident.generate_word(writer),
            Lam(ref lam) => lam.generate_word(writer),
            List(ref list) => list.generate_word(writer),
            NixString(ref s) => s.generate_word(writer),
            Projection(ref p) => p.generate_word(writer),
            ConstNum(ref n) => n.generate_word(writer),
            Optional(ref o) => o.generate_word(writer),
            Let(ref r#let) => r#let.generate_word(writer),
            IfElse(ref ifelse) => ifelse.generate_word(writer),
            Eq(ref eq) => eq.generate_word(writer),
        }
    }
}

impl std::fmt::Display for Expr {
    fn fmt(&self, fmt: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let mut s = FmtWriter::new(String::new());
        self.generate_word(&mut s)?;
        let s = s.into_inner();
        fmt.write_str(&s)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let f = Box::new(Expr::Ident(Ident::new("f")));
        let a = Box::new(Expr::Ident(Ident::new("a")));
        let f = Box::new(Expr::App(App(f, a.clone())));
        let expr = Expr::App(App(f, a));
        let mut s = FmtWriter::new(String::new());
        expr.generate_word(&mut s).unwrap();
        let s = s.into_inner();
        assert_eq!("f a a", s);
    }

    #[test]
    fn attrs() {
        let attrs = attrs!(
            rec {
                attrs_path!(
                    ident!("a").to_key(),
                    ident!("b").to_key()
                ) => nix_string!("0");
            }
        );
        let mut s = FmtWriter::new(String::new());
        attrs.generate_word(&mut s).unwrap();
        let s = s.into_inner();
        assert_eq!(
            r##"rec {
  a.b = "0";
}"##,
            s
        )
    }

    #[test]
    fn it_works2() {
        let a = ident!("a");
        let args = ident!("args");
        let args2 = ident!("args2");
        let abc = ident!("abc");
        let formal_arg = formal_arg!(a @ {
            args,
            args2 ;? Expr::ConstNum(ConstNum::Signed(0)),
            abc ;? nix_string!(""),
            ...
        });
        let lam = lambda!(
            formal formal_arg =>
            Box::new(nix_string!(""))
        );
        let mut s = FmtWriter::new(String::new());
        lam.generate_word(&mut s).unwrap();
        let s = s.into_inner();
        assert_eq!(
            r##"(a@{
    args
  , args2 ? 0
  , abc ? ""
  , ...
}:
  "")"##,
            s
        );
        let list = list!(nix_string!(""));
        let mut s = FmtWriter::new(String::new());
        list.generate_word(&mut s).unwrap();
        let s = s.into_inner();
        assert_eq!(
            r#"[
  ""
]"#,
            s
        );
    }
}
