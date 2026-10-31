# playground schema compare

🔀 Compare the subjects of two registries (or two contexts)

In an mdc-\* environment, `--from` and `--to` are the clusters (europe and  
us by default); `--from-context` / `--to-context` pick a context on each  
side (the destination context of a Schema Linking exporter, typically).  
Elsewhere, compare two contexts of the registry.

For each subject: ✅ same versions, schemas and ids; ⬅️ / ➡️ only on one  
side; ❌ missing versions, different schemas, or the same schema with  
another id (records written on one side don't decode on the other) and  
a different subject-level compatibility.

Exit code: 0 identical, 1 different.

## Usage

```bash
playground schema compare [OPTIONS]
```

## Options

#### `--from CLUSTER`

⬅️ Cluster of the left side (mdc-\* environments, default europe)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

#### `--to CLUSTER`

➡️ Cluster of the right side (mdc-\* environments, default us)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

#### `--from-context CONTEXT`

🗂️ Context of the left side (default: the default context)

#### `--to-context CONTEXT`

🗂️ Context of the right side (default: the default context)

#### `--subject-prefix PREFIX`

🔎 Only the subjects starting with this prefix

#### `--json`

📗 Print the result as JSON, and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground schema compare --from europe --to us
```

```bash
playground schema compare --from europe --to us --to-context .europe
```

```bash
playground schema compare --from-context . --to-context .migrated --json
```


