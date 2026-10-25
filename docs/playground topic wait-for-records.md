# playground topic wait-for-records

⏳ Wait for a topic to contain a minimum number of records

Counts the records in the topic every `--interval` seconds (same count as  
'get-number-records') until there are at least  
`--min-expected-messages`, and fails after `--max-wait` seconds. A topic  
that does not exist yet counts as empty, so it can be used before a  
source connector has created its topic.

🎓 Tip: in an example script, use it instead of a fixed sleep before  
checking what a source connector produced.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%AA%9B-a-producer-gets-recordtoolargeexception

## Usage

```bash
playground topic wait-for-records [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--min-expected-messages MIN_EXPECTED_MESSAGES`

🔢 Minimum number of records to wait for (default is 1)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1`

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait (default is 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--interval INTERVAL`

🔁 Interval in seconds between checks (default is 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

## Examples

```bash
playground topic wait-for-records --topic filestream
```

```bash
playground topic wait-for-records --topic filestream --min-expected-messages 10 --max-wait 300
```

## Example output

```text
$ playground topic wait-for-records --topic filestream --min-expected-messages 5
17:22:53 ℹ️ ⏳ Waiting up to 120 seconds for topic filestream to contain at least 5 records
17:22:58 ℹ️ ✅ topic filestream contains 5 records (expected at least 5) after 5 seconds
```


