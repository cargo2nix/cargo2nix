use std::{collections::BTreeMap, sync::Arc};

use serde::{ser, Serialize};

use crate::ast::{AttrSet, AttrsPath, ConstNum, Expr, Ident, List, NixString, Optional};

pub struct Serializer;

#[derive(Debug)]
pub enum Error {
    Custom(String),
}

impl std::fmt::Display for Error {
    fn fmt(&self, fmt: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Error::Custom(ref custom) => write!(fmt, "custom: {}", custom),
        }
    }
}

impl ser::Error for Error {
    fn custom<T: std::fmt::Display>(msg: T) -> Self {
        Error::Custom(msg.to_string())
    }
}

impl std::error::Error for Error {}

impl ser::Serializer for Serializer {
    type Ok = Expr;
    type Error = Error;
    type SerializeSeq = ListSerializer;
    type SerializeTuple = ListSerializer;
    type SerializeTupleStruct = ListSerializer;
    type SerializeTupleVariant = ListSerializer;
    type SerializeMap = AttrSetSerializer;
    type SerializeStruct = AttrSetSerializer;
    type SerializeStructVariant = AttrSetSerializer;
    fn serialize_bool(self, v: bool) -> Result<Self::Ok, Self::Error> {
        if v {
            Ok(Expr::Ident(Ident::new("true")))
        } else {
            Ok(Expr::Ident(Ident::new("false")))
        }
    }
    fn serialize_i8(self, v: i8) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Signed(v as i64)))
    }
    fn serialize_i16(self, v: i16) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Signed(v as i64)))
    }
    fn serialize_i32(self, v: i32) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Signed(v as i64)))
    }
    fn serialize_i64(self, v: i64) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Signed(v as i64)))
    }
    fn serialize_u8(self, v: u8) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Unsigned(v as u64)))
    }
    fn serialize_u16(self, v: u16) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Unsigned(v as u64)))
    }
    fn serialize_u32(self, v: u32) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Unsigned(v as u64)))
    }
    fn serialize_u64(self, v: u64) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Unsigned(v as u64)))
    }
    fn serialize_f32(self, v: f32) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Float(v as f64)))
    }
    fn serialize_f64(self, v: f64) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::ConstNum(ConstNum::Float(v as f64)))
    }
    fn serialize_char(self, v: char) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::NixString(NixString(format!("{}", v))))
    }
    fn serialize_str(self, v: &str) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::NixString(NixString(format!("{}", v))))
    }
    fn serialize_bytes(self, v: &[u8]) -> Result<Self::Ok, Self::Error> {
        Ok(List(
            v.into_iter()
                .map(|x| Expr::ConstNum(ConstNum::Unsigned(*x as u64)))
                .collect(),
        )
        .into())
    }
    fn serialize_none(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::Optional(Optional(None)))
    }
    fn serialize_some<T: ?Sized>(self, value: &T) -> Result<Self::Ok, Self::Error>
    where
        T: Serialize,
    {
        value.serialize(self)
    }
    fn serialize_unit(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::List(List(vec![])))
    }
    fn serialize_unit_struct(self, _name: &'static str) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::AttrSet(AttrSet {
            recursive: false,
            attrs: Default::default(),
        }))
    }
    fn serialize_unit_variant(
        self,
        _name: &'static str,
        _variant_index: u32,
        _variant: &'static str,
    ) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::AttrSet(AttrSet {
            recursive: false,
            attrs: Default::default(),
        }))
    }
    fn serialize_newtype_struct<T: ?Sized>(
        self,
        _name: &'static str,
        value: &T,
    ) -> Result<Self::Ok, Self::Error>
    where
        T: Serialize,
    {
        value.serialize(self)
    }
    fn serialize_newtype_variant<T: ?Sized>(
        self,
        _name: &'static str,
        _variant_index: u32,
        _variant: &'static str,
        value: &T,
    ) -> Result<Self::Ok, Self::Error>
    where
        T: Serialize,
    {
        value.serialize(self)
    }
    fn serialize_seq(self, _len: Option<usize>) -> Result<Self::SerializeSeq, Self::Error> {
        Ok(ListSerializer::new())
    }
    fn serialize_tuple(self, _len: usize) -> Result<Self::SerializeTuple, Self::Error> {
        Ok(ListSerializer::new())
    }
    fn serialize_tuple_struct(
        self,
        _name: &'static str,
        _len: usize,
    ) -> Result<Self::SerializeTupleStruct, Self::Error> {
        Ok(ListSerializer::new())
    }
    fn serialize_tuple_variant(
        self,
        _name: &'static str,
        _variant_index: u32,
        _variant: &'static str,
        _len: usize,
    ) -> Result<Self::SerializeTupleVariant, Self::Error> {
        Ok(ListSerializer::new())
    }
    fn serialize_map(self, _len: Option<usize>) -> Result<Self::SerializeMap, Self::Error> {
        Ok(AttrSetSerializer::new())
    }
    fn serialize_struct(
        self,
        _name: &'static str,
        _len: usize,
    ) -> Result<Self::SerializeStruct, Self::Error> {
        Ok(AttrSetSerializer::new())
    }
    fn serialize_struct_variant(
        self,
        _name: &'static str,
        _variant_index: u32,
        _variant: &'static str,
        _len: usize,
    ) -> Result<Self::SerializeStructVariant, Self::Error> {
        Ok(AttrSetSerializer::new())
    }
}

pub struct ListSerializer {
    list: Vec<Expr>,
}

impl ListSerializer {
    fn new() -> Self {
        Self { list: vec![] }
    }
}

pub struct AttrSetSerializer {
    attrs: BTreeMap<AttrsPath, Arc<Expr>>,
    key: Option<String>,
}

impl AttrSetSerializer {
    fn new() -> Self {
        Self {
            attrs: Default::default(),
            key: Default::default(),
        }
    }
}

impl ser::SerializeSeq for ListSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_element<T>(&mut self, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        Ok(self.list.push(value.serialize(Serializer)?))
    }

    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::List(List(self.list)))
    }
}

impl ser::SerializeTuple for ListSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_element<T>(&mut self, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        Ok(self.list.push(value.serialize(Serializer)?))
    }

    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::List(List(self.list)))
    }
}

impl ser::SerializeTupleStruct for ListSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_field<T>(&mut self, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        Ok(self.list.push(value.serialize(Serializer)?))
    }

    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::List(List(self.list)))
    }
}

impl ser::SerializeTupleVariant for ListSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_field<T>(&mut self, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        Ok(self.list.push(value.serialize(Serializer)?))
    }

    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::List(List(self.list)))
    }
}

impl ser::SerializeMap for AttrSetSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_key<T>(&mut self, key: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        match key.serialize(Serializer)? {
            Expr::NixString(NixString(key)) => {
                self.key = Some(key);
                Ok(())
            }
            Expr::Ident(key) => {
                self.key = Some(key.into_inner());
                Ok(())
            }
            expr => Err(Error::Custom(format!("unknown key type, {}", expr))),
        }
    }
    fn serialize_value<T>(&mut self, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        let key = self
            .key
            .take()
            .expect("key must be set before setting value");
        let value = value.serialize(Serializer)?;
        self.attrs.insert(attrs_path!(key!(&key)), Arc::new(value));
        Ok(())
    }
    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::AttrSet(AttrSet {
            recursive: false,
            attrs: self.attrs,
        }))
    }
}

impl AttrSetSerializer {
    fn push_field<T>(&mut self, key: &'static str, value: &T) -> Result<(), Error>
    where
        T: ?Sized + Serialize,
    {
        let key = match key.serialize(Serializer)? {
            Expr::NixString(NixString(key)) => key,
            Expr::Ident(key) => key.into_inner(),
            expr => return Err(Error::Custom(format!("unknown key type, {}", expr))),
        };
        let value = value.serialize(Serializer)?;
        if let Expr::Optional(Optional(None)) = value {
            Ok(())
        } else {
            self.attrs.insert(attrs_path!(key!(&key)), Arc::new(value));
            Ok(())
        }
    }
}

impl ser::SerializeStruct for AttrSetSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_field<T>(&mut self, key: &'static str, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        self.push_field(key, value)
    }
    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::AttrSet(AttrSet {
            recursive: false,
            attrs: self.attrs,
        }))
    }
}

impl ser::SerializeStructVariant for AttrSetSerializer {
    type Ok = Expr;
    type Error = Error;
    fn serialize_field<T>(&mut self, key: &'static str, value: &T) -> Result<(), Self::Error>
    where
        T: ?Sized + Serialize,
    {
        self.push_field(key, value)
    }
    fn end(self) -> Result<Self::Ok, Self::Error> {
        Ok(Expr::AttrSet(AttrSet {
            recursive: false,
            attrs: self.attrs,
        }))
    }
}
