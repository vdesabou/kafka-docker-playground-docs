# playground connector logs

🕵️  Tail and follow connect logs

The logs of the worker running your connector. Combine it with  
`playground connector log-level` to get more than the stack trace, and  
with `--wait-for-log` to block until a given line appears, which is how  
examples assert that something happened.

For self managed connectors, this is a shortcut for `playground container logs --container connect`  
(connect-us / connect-europe in mdc environments): `--no-follow`, `--errors`, `--since`, `--tail` and `--grep` are passed through.  
When `--connector` is set (and none of `--grep`, `--errors`, `--wait-for-log`, `--open`), only the lines mentioning the  
connector are kept.

For Fully Managed connectors, the logs come from the confluent CLI ('confluent connect logs', last 71 hours),  
limitations apply (see https://docs.confluent.io/cloud/current/connectors/logging-cloud-connectors.html#using-ccloud-cli):  
`--errors` keeps the ERROR level, `--grep` is a search text, and `--wait-for-log` polls until the text is found or `--max-wait`.

🎓 Tip: from a script or an AI agent, always pass `--no-follow`, `--errors` or `--wait-for-log`, otherwise the command never returns for a self managed connector.

☁️ Fully managed: supported, with the confluent CLI (see above)

## Usage

```bash
playground connector logs [OPTIONS]
```

## Options

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--open`

🔖 Save output to a file and open with text editor set with playground config editor `<editor>` (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--wait-for-log`, `--grep`, `--errors`

#### `--wait-for-log, -w LOG`

😴 Wait until log appears (exits 1 after `--max-wait`)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--grep`, `--errors`

#### `--max-wait, -m MAX_WAIT`

⏳ Max time to wait when using `--wait-for-log`: seconds, or 30s, 10m, 1h (default 600 seconds)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `600`

#### `--grep GREP`

🎯 Grep pattern to filter logs (search text for fully managed connectors)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--wait-for-log`, `--errors`

#### `--since SINCE`

🕐 Only show logs newer than a relative duration (10m, 1h) or a timestamp (self managed only)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--wait-for-log`

#### `--tail LINES`

🔢 Number of lines to show from the end of the logs, or "all" (self managed only)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--wait-for-log`

#### `--no-follow`

🛑 Print the logs and exit instead of following them (self managed only, fully managed logs are never followed)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--wait-for-log`

#### `--errors`

🔥 Only show a digest of ERROR/FATAL records, then exit (fully managed: only the ERROR level)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--wait-for-log`, `--grep`

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
playground connector logs --no-follow --tail 100
```

```bash
playground connector logs --errors
```

```bash
playground connector logs --connector filestream-sink --since 10m --no-follow
```

```bash
playground connector logs --wait-for-log "Started FileStreamSinkTask" --max-wait 120
```


