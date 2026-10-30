# playground consumer-group reset-offsets

⏪ Reset the committed offsets of a consumer group

Wraps kafka-consumer-groups `--reset-offsets`: set exactly one of  
`--to-earliest`, `--to-latest`, `--to-offset`, `--to-datetime`, `--shift-by`  
or `--by-duration`. All the topics of the group are reset, unless  
`--topic` is set (topic, or topic:partition[,partition]).

The offsets are changed right away (kafka-consumer-groups `--execute`):  
use `--dry-run` to only see the new offsets. The group must have no  
active member.

🎓 Tip: for a sink connector (group connect-`<connector>`), use  
`playground connector offsets reset|alter`, which stops and resumes  
the connector for you.

## Usage

```bash
playground consumer-group reset-offsets [OPTIONS]
```

## Options

#### `--group, -g GROUP`

👥 Consumer group name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--topic, -t TOPIC`

🗳 Topic to reset (topic, or topic:partition[,partition])

ℹ️ If not set, all the topics of the group are reset

#### `--to-earliest`

⏮️ Reset to the earliest offset

#### `--to-latest`

⏭️ Reset to the latest offset (skip everything that is in the topic)

#### `--to-offset OFFSET`

📍 Reset to this offset

#### `--to-datetime DATETIME`

📅 Reset to the first offset at or after this date (YYYY-MM-DDTHH:mm:SS.sss, e.g. 2026-10-20T08:00:00.000)

#### `--shift-by SHIFT`

↔️ Move the offsets by this number of records (negative to go back, e.g. -100)

#### `--by-duration DURATION`

⏱️ Reset to the offsets of this long ago (ISO-8601 duration, e.g. PT1H for one hour ago, P1D for one day)

#### `--dry-run`

🧪 Only display the new offsets, do not change them

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground consumer-group reset-offsets --group my-app --to-earliest
```

```bash
playground consumer-group reset-offsets --group my-app --topic orders --shift-by -100 --dry-run
```

```bash
playground consumer-group reset-offsets --group my-app --to-datetime 2026-10-20T08:00:00.000
```

## Example output

```text
$ playground consumer-group reset-offsets --group my-app --to-earliest
17:23:03 ℹ️ ⏪ Resetting offsets of consumer group my-app on all its topics to earliest
GROUP                          TOPIC                          PARTITION  NEW-OFFSET
my-app                         filestream                     0          0
17:23:04 ℹ️ ✅ Offsets of consumer group my-app reset
```


