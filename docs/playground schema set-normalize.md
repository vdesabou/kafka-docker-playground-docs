# playground schema set-normalize

🧽 Set normalize at schema registry level

With normalization on, the registry rewrites a schema into a canonical  
form before storing it, so two schemas that differ only in field order,  
whitespace or the way defaults are written get the same id instead of  
creating a new version every time.

This applies to the whole registry, not to one subject. Turn it on when  
an example keeps registering a new version of an unchanged schema.

See https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization

## Usage

```bash
playground schema set-normalize [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--value VALUE`

true or false

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `true`, `false`

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground schema set-normalize --value true
```


