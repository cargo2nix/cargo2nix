use std::fmt;

pub struct Indented<W> {
    indent: u32,
    writer: W,
    need_indent: bool,
}

impl<W> Indented<W> {
    pub fn new(writer: W) -> Self {
        Self {
            indent: 0,
            writer,
            need_indent: true,
        }
    }

    pub fn indent(&mut self, n: u32) -> Indented<&mut W> {
        let Self {
            indent,
            writer,
            need_indent,
        } = self;
        Indented {
            indent: *indent + n,
            writer,
            need_indent: *need_indent,
        }
    }
}

impl<W> fmt::Write for Indented<W>
where
    W: fmt::Write,
{
    fn write_str(&mut self, mut s: &str) -> fmt::Result {
        let Self {
            indent,
            writer: w,
            need_indent,
        } = self;

        while !s.is_empty() {
            let (line, remaining, has_new_line) = match s.find("\n") {
                Some(ix) => (&s[..ix], &s[ix + 1..], true),
                None => (s, "", false),
            };
            s = remaining;

            if *need_indent && *indent > 0 {
                write!(w, "{:indent$}", ' ', indent = *indent as usize)?;
                *need_indent = false;
            }

            if has_new_line {
                writeln!(w, "{}", line)?;
                *need_indent = true;
            } else {
                write!(w, "{}", line)?;
            }
        }

        Ok(())
    }
}

#[derive(Clone)]
pub struct DisplayFn<F>(pub F);

impl<F> fmt::Display for DisplayFn<F>
where
    F: Fn(&mut fmt::Formatter) -> fmt::Result,
{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        (self.0)(f)
    }
}
