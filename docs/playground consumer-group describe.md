# playground consumer-group describe

🔬 Describe consumer group

By default, shows the committed offset, log end offset and lag of  
every partition consumed by the group, followed by the total lag.  
Use `--state` for the coordinator, assignment strategy and state, and  
`--members` for the members and their assigned partitions.

## Usage

```bash
playground consumer-group describe [OPTIONS]
```

## Options

#### `--group, -g GROUP`

👥 Consumer group name

ℹ️ If not set, all consumer groups are described

#### `--state`

🚦 Display state of the group (coordinator, assignment strategy, state, number of members)

#### `--members`

🧑‍🤝‍🧑 Display members of the group and their assigned partitions

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground consumer-group describe --group connect-http-sink
```

```bash
playground consumer-group describe --group my-app --members
```

```bash
playground consumer-group describe --group my-app --state
```

## Example output

```text
$ playground consumer-group describe --group connect-filestream-sink
17:23:03 ℹ️ 🔬 Describing consumer group connect-filestream-sink

GROUP                   TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID                                                               HOST            CLIENT-ID
connect-filestream-sink filestream      0          5               5               0               connector-consumer-filestream-sink-0-01fb326c-c344-4c45-ba76-b8c048b539f4 /10.89.0.7      connector-consumer-filestream-sink-0
17:23:04 ℹ️ 🏁 Total lag for consumer group connect-filestream-sink: 0
```


