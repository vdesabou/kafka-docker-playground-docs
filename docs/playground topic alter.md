# playground topic alter

🪛 Alter topic config  
  
Changes topic level settings on a live topic, which is how you  
reproduce behaviour driven by configuration: a small  
max.message.bytes to trigger a record too large error, a short  
retention.ms to expire data, a compacted cleanup.policy, and so on.

## Usage

```bash
playground topic alter [OPTIONS] [--] [ARGUMENTS...]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--topic, -t TOPIC*

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Examples

```bash
playground topic alter --topic atopic --add-config max.message.bytes=5242940

```


