
# Coat.Persistent

---

# Reference

## Global Functions

#### persistent( modname, [ { primary_key = val, table_name = val } ] )

Create a Coat Persistent class as a standard Lua module.

The default `primary_key` is `id`.

The default `table_name` is `modname`
with lower case and `.` replaced by `_`.

## Functions in the built Class

#### create( args )

Instanciates and saves and returns an object or an array of object.

#### connection()

Returns the current LuaSQL connection object.

#### obj:delete()

Deletes the object.

#### establish_connection( driver, options, ... )

Create and returns an connection using the LuaSQL driver.
`options` are forwarded to the LuaSQL method `env:conn()`.

#### find()

Returns an iterator over all records.

#### find( id )

Returns an iterator over record with the primary key is the number `id`.

#### find( condition )

Returns an iterator over record selected by the SQL `condition`.

#### find_by_*name*( val )

Returns an iterator over record with the attribute name is `val`.

#### find_by_sql( sql )

Returns an iterator over record found by a raw SQL `select` request.

#### has_p.name = { options }

Adds a persistent attribute name, all options are forwarded to `Coat.has`.

And adds a method _`find_by_name`_.

#### has_one.name = { class_name = val, foreign_key = val }

#### has_many.name = { class_name = val }

#### obj:save()

Saves the object and returns the value of its primary key.

# Examples

```lua
require 'Coat.Persistent'

persistent 'Person'

has_p.name = { is = 'rw', isa = 'string' }
has_p.age = { is = 'rw', isa = 'number' }

sql_create = [[
    CREATE TABLE person (
        id INTEGER,
        name CHAR(64),
        age INTEGER
    )
]]
```

```lua
local conn = Person.establish_connection('sqlite3', 'test.db')
conn:execute(Person.sql_create)
```

```lua
Person.create { name = 'John', age = 23 }
Person.create {
    { name = 'Brenda', age = 31 },
    { name = 'Nate', age = 34 },
    { name = 'Dave', age = 29 },
}

for p in Person.find() do
    print(p.id, p.name, p.age)
end

p = Person.find_by_name('Brenda')()
p.age = p.age + 1
p:save()

p = Person.find(1)()
p:delete()

for p in Person.find 'age > 30' do
    print(p.id, p.name, p.age)
end
```
