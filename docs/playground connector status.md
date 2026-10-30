# playground connector status

🧩 Show status of all connectors

The connector state, the state of each task, and for a failed task the  
full stack trace, which is the thing you actually need. Add `--verbose` to  
see the underlying REST call.

## Usage

```bash
playground connector status [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector status
```

## Example output

```text
$ playground connector status
17:22:05 ℹ️ 🧩 Displaying status for 🌎onprem connector filestream-sink
Name                           Status       Tasks                                                        Stack Trace
-------------------------------------------------------------------------------------------------------------
filestream-sink                ✅ RUNNING  0:🟢 RUNNING                 -
-------------------------------------------------------------------------------------------------------------
```


