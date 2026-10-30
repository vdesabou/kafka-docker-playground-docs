# playground topic alter

🪛 Alter topic config

Changes topic level settings on a live topic, which is how you  
reproduce behaviour driven by configuration: a small  
max.message.bytes to trigger a record too large error, a short  
retention.ms to expire data, a compacted cleanup.policy, and so on.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%AA%9B-a-producer-gets-recordtoolargeexception

## Usage

```bash
playground topic alter [OPTIONS] [--] [ARGUMENTS...]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground topic alter --topic atopic --add-config max.message.bytes=5242940

```


