# playground schema contexts

🗂️ List the contexts of the registry, with their number of subjects and mode

Contexts are separate namespaces of subjects and schema ids in one  
registry. Schema Linking exports into one (.`<name>`) on the  
destination: a consumer of the default context doesn't find those ids.

## Usage

```bash
playground schema contexts [OPTIONS]
```

## Options

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground schema contexts
```

```bash
playground schema contexts --cluster us --json
```


