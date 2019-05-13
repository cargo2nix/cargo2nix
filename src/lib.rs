#[macro_use]
extern crate derive_more;
extern crate tokio;
extern crate tokio_process;

#[macro_use]
extern crate failure;
extern crate futures;

pub mod http_crate;

#[cfg(test)]
mod tests {

    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4)
    }
}
