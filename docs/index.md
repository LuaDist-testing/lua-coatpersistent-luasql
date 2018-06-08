
# lua-CoatPersistent

---

## Overview

lua-CoatPersistent is an Object-Relational Mapping
for [lua-Coat](http://fperrad.github.io/lua-Coat).
It is built over the modules
[LuaSQL](http://www.keplerproject.org/luasql/) and
[Dado](http://www.ccpa.puc-rio.br/software/dado).
It could support all database engine which has a driver in LuaSQL.

Another variant is built over the module
[lsqlite3](http://lua.sqlite.org/) instead of LuaSQL.

## Lineage

lua-CoatPersistent is a Lua port of
[Coat::Persistent](http://search.cpan.org/~sukria/Coat-Persistent/)
, a Perl module, which is inspired by Ruby on Rails
[Active Record](http://rubyonrails.org/).

## Status

lua-CoatPersistent is in early stage.

It's developed for Lua 5.1, 5.2 & 5.3.

## Download

lua-CoatPersistent source can be downloaded from
[GitHub](http://github.com/fperrad/lua-CoatPersistent/releases/).

## Installation

Two variants are available, LuaSQL or lsqlite3 based

lua-CoatPersistent is available via LuaRocks:

```sh
luarocks install lua-coatpersistent-luasql
# luarocks install lua-coatpersistent-lsqlite3
```

or manually, with:

```sh
make install.luasql
# make install.lsqlite3
```

## Test

The test suite requires the module
[lua-TestMore](http://fperrad.github.io/lua-TestMore/)
and LuaSQL-SQLite3.

```sh
make test.luasql
# make test.lsqlite3
```

## Copyright and License

Copyright &copy; 2010-2018 Fran&ccedil;ois Perrad
[![OpenHUB](http://www.openhub.net/accounts/4780/widgets/account_rank.gif)](http://www.openhub.net/accounts/4780?ref=Rank)
[![LinkedIn](http://www.linkedin.com/img/webpromo/btn_liprofile_blue_80x15.gif)](http://www.linkedin.com/in/fperrad)

This library is licensed under the terms of the MIT/X11 license,
like Lua itself.
