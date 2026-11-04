# playground connector show-lag

🐢 Show lag of sink connector

The consumer lag of the sink, refreshed every `--interval` seconds, so you  
see whether it is catching up, standing still or falling behind. A lag  
that does not move while the connector reports RUNNING means the tasks  
are stuck rather than slow.

It will run until all lag becomes 0 (press ctrl-c to exit), or until  
`--max-wait`. `--once` (or `--json`) takes a single snapshot instead. The  
consumer group is connect-`<connector>`, or the one set with  
consumer.override.group.id.

☁️ Fully managed: supported (custom connectors too)

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-offsets-and-lag  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%E2%8F%AA-the-lag-of-a-sink-is-stuck

## Usage

```bash
playground connector show-lag [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--interval INTERVAL`

🔁 Interval between lag checks: seconds, or 30s, 1m (default is 20 seconds)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20`

#### `--max-wait MAX_WAIT`

⏳ Max time to wait for lag to become 0: seconds, or 30s, 5m, 1h. If set to 0 (default), it will run until all lag becomes 0.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

#### `--fail-on-timeout`

❌ Exit 1 when the lag is still not 0 after `--max-wait` seconds (by default it logs a warning and exits 0)

#### `--once`

📸 Show the lag once and exit, without waiting for it to reach 0 (also when the tasks are not RUNNING: committed offsets)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--fail-on-timeout`

#### `--json`

🤖 Print the lag per partition and the total as JSON on stdout, and nothing else (implies `--once`, the log lines go to stderr)

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground connector show-lag
```

```bash
playground connector show-lag --connector filestream-sink --once
```

```bash
playground connector show-lag --connector filestream-sink --json
```

```bash
playground connector show-lag --connector filestream-sink --interval 5 --max-wait 120 --fail-on-timeout
```

## Example output

```text
$ playground connector show-lag
17:22:14 ℹ️ 🏁 consumer lag for 🌎onprem connector filestream-sink is 0 ! took: 0min 2sec
topic: filestream partition: 0   current-offset: 5          end-offset: 5          lag: 0          [🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹] 100% 🏁
```


