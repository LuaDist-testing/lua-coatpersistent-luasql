
lua-CoatPersistent : an ORM for lua-Coat
========================================

[![Build Status](https://travis-ci.org/fperrad/lua-CoatPersistent.png)](https://travis-ci.org/fperrad/lua-CoatPersistent)
[![Coverage Status](https://coveralls.io/repos/fperrad/lua-CoatPersistent/badge.png?branch=master)](https://coveralls.io/r/fperrad/lua-CoatPersistent?branch=master)
[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](COPYRIGHT)

Introduction
------------

lua-CoatPersistent is a Lua 5.1 port of [Coat::Persistent](http://search.cpan.org/~sukria/Coat-Persistent),
a Perl module, which is inspired by Ruby on Rails Active Record.

lua-CoatPersistent is an Object-Relational Mapping for [lua-Coat](http://fperrad.github.io/lua-CoatPersistent).
It is built over the modules [LuaSQL](http://www.keplerproject.org/luasql)
and [Dado](http://www.ccpa.puc-rio.br/software/dado).
It could support all database engine which has a driver in LuaSQL.

Another variant is built over the module [lsqlite3](http://lua.sqlite.org/)
instead of LuaSQL.

Links
-----

The homepage is at [http://fperrad.github.io/lua-CoatPersistent](http://fperrad.github.io/lua-CoatPersistent),
and the sources are hosted at [http://github.com/fperrad/lua-CoatPersistent](http://github.com/fperrad/lua-CoatPersistent).

Copyright and License
---------------------

Copyright (c) 2010-2018 Francois Perrad

This library is licensed under the terms of the MIT/X11 license, like Lua itself.

