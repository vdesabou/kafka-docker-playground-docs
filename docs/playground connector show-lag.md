# playground connector show-lag

🐢 Show lag of sink connector

The consumer lag of the sink, refreshed every `--interval` seconds, so you  
see whether it is catching up, standing still or falling behind. A lag  
that does not move while the connector reports RUNNING means the tasks  
are stuck rather than slow.

It will run until all lag becomes 0 (press ctrl-c to exit)

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

Interval between lag checks (default is 20 seconds).

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20`

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait for lag to become 0. If set to 0 (default), it will run until all lag becomes 0.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

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

## Example output

```text
$ playground connector show-lag
17:22:14 ℹ️ 🏁 consumer lag for 🌎onprem connector filestream-sink is 0 ! took: 0min 2sec
topic: filestream partition: 0   current-offset: 5          end-offset: 5          lag: 0          [🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹] 100% 🏁
```


