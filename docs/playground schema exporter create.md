# playground schema exporter create

🔗 Create an exporter, then wait until it runs

## Usage

```bash
playground schema exporter create [OPTIONS]
```

## Options

#### `--name NAME`

📛 Exporter name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--to CLUSTER`

➡️ Destination cluster in an mdc-\* environment (default: the other one)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

#### `--destination-url URL`

🌐 Url of the destination registry, as seen from the source registry

#### `--destination-auth USER-INFO`

🔑 `<user>:<password>` (or API key:secret) of the destination registry

#### `--context-type TYPE`

🗂️ Where the subjects land: AUTO (.`<exporter name>`), CUSTOM (`--destination-context`) or NONE (default context). Default: CUSTOM with `--destination-context`, else AUTO

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `AUTO`, `CUSTOM`, `NONE`

#### `--destination-context CONTEXT`

🗂️ Destination context for `--context-type` CUSTOM

#### `--subjects SUBJECTS`

🔰 Comma separated subjects or patterns to export (default: \*)

#### `--subject-rename-format FORMAT`

✏️ Rename the subjects in the destination, e.g. dc_${subject} (${subject} is replaced by the subject name)

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
playground schema exporter create --name eu-to-us --cluster europe --to us --destination-context europe
```

```bash
playground schema exporter create --name to-dr --destination-url https://dr-registry:8081 --destination-auth user:password --subjects "orders-value,payments-*"
```


