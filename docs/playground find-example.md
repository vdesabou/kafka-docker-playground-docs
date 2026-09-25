# playground find-example

🔎 Find examples matching a free-text query, without the interactive picker  
  
Searches every runnable example script (connect/, ccloud/, ksqldb/,  
flink/, reproduction-models/, ...) by path, connector class, README title  
and script body. Every word of the query must match somewhere; matches in  
the path and connector class rank higher than matches in the body.  
  
Prints the ready-to-paste 'playground run -f' command for each hit, best  
first. Use 'playground run' instead to browse examples interactively.

## Usage

```bash
playground find-example QUERY [OPTIONS] [--] [MORE QUERY WORDS...]
```

## Arguments

#### *QUERY*

🔤 Free-text query, e.g. "oracle cdc ssl", "fully managed s3 sink" or "jdbc source proxy"

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *MORE QUERY WORDS...*

extra words are appended to the query, so quoting it is optional

## Options

#### *--category CATEGORY*

📂 Restrict the search to one top-level folder

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | connect, ccloud, ksqldb, flink, schema-registry, rest-proxy, multi-data-center, other, operator, academy, environment, reproduction-models

#### *--limit LIMIT*

🔢 Maximum number of hits (default 10)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 10

## Examples

```bash
playground find-example "s3 sink proxy"
```

```bash
playground find-example debezium postgres fully managed
```

```bash
playground find-example "oracle cdc ssl" --category connect --limit 3
```


