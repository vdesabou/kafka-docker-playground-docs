# playground db wait-for-rows

⏳ Wait for a table to contain a minimum number of rows

Counts the rows of `--table` (SELECT COUNT(\*), with `--where` if set) every  
`--interval` seconds until there are at least `--min-expected-rows`, and  
fails after `--max-wait` seconds. A table that does not exist yet counts  
as empty, so it can be used before a sink connector has created it  
(auto.create=true).

`--query` replaces the count with any query that returns one number.  
For MongoDB, `--table` is the collection and `--where` a filter document  
({"status": "done"}).

The database, user and password are found as for `playground db sql`.

🎓 Tip: in an example script, use it instead of a fixed sleep before  
checking what a sink connector wrote, then show the rows with  
`playground db sql`.

## Usage

```bash
playground db wait-for-rows [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of the database

ℹ️ If not set, the only running container whose image is a supported database

#### `--engine ENGINE`

🛢️ Database engine, when the image name of the container does not tell it

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `oracle`, `postgres`, `mysql`, `mariadb`, `sqlserver`, `db2`, `mongodb`

#### `--user, -u USER`

👤 User to connect with

ℹ️ If not set, the admin user of the container environment (see above)

#### `--password PASSWORD`

🔑 Password of `--user`

ℹ️ If not set, the password of the container environment

#### `--database, -d DATABASE`

🗄️ Database (Oracle: service name, ORCLPDB1 for the pluggable database)

ℹ️ If not set, the database of the container environment

#### `--table, -t TABLE`

🗂️ Table (or MongoDB collection) to count the rows of, schema prefix allowed (MYUSER.CUSTOMERS)

ℹ️ The name is used as is: quote it as the database expects when it is case sensitive ("orders" for Oracle)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--query`

#### `--where WHERE`

🔎 Condition of the count (SQL: id \> 10, MongoDB: a filter document)

#### `--query QUERY`

✍️ Query that returns one number, instead of `--table` / `--where`

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--table`

#### `--min-expected-rows MIN_EXPECTED_ROWS`

🔢 Minimum number of rows to wait for (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1`

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait (default is 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--interval INTERVAL`

🔁 Interval in seconds between checks (default is 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground db wait-for-rows --table customers --min-expected-rows 10
```

```bash
playground db wait-for-rows --table ORDERS --database ORCLPDB1 --user C##MYUSER --password mypassword
```

```bash
playground db wait-for-rows --table orders --where "status = 'done'" --max-wait 300
```

```bash
playground db wait-for-rows --query "select count(distinct id) from orders" --min-expected-rows 5
```

```bash
playground db wait-for-rows --table customers --where '{"name": "alice"}' --database inventory
```

## Example output

```text
$ playground db wait-for-rows --table customers --min-expected-rows 4 --interval 2
10:53:09 ℹ️ ⏳ Waiting up to 120 seconds for table customers to contain at least 4 rows (postgres container)
10:53:09 ℹ️ ⌛ table customers contains 2 rows (expected at least 4)
10:53:13 ℹ️ ✅ table customers contains 4 rows (expected at least 4) after 4 seconds
```

```text
$ playground db wait-for-rows --table nope --max-wait 3 --interval 1
10:51:21 ℹ️ ⏳ Waiting up to 3 seconds for table nope to contain at least 1 rows (postgres container)
10:51:21 ℹ️ ⌛ table nope does not exist yet (expected at least 1)
10:51:24 🔥 ❌ table nope does not exist yet after 3 seconds, expected at least 1 rows
```


