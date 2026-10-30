# playground topic delete

❌ Delete topic and associated schema/subject if applicable

Also removes the key and value subjects from the schema registry,  
which is what you usually want: a topic re-created with a leftover  
subject keeps the old compatibility rules and the old schema history.  
Keep them with `--skip-delete-schema`. When the topic no longer exists,  
its leftover key and value subjects are still deleted.

A regex is accepted, matched in full, to clean up a family of topics  
at once.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-topic-administration  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%AA%9B-a-producer-gets-recordtoolargeexception

## Usage

```bash
playground topic delete [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--topic, -t TOPIC`

🗳 Topic name or regex pattern (full match)

Examples: my-topic, my-topic-.\*

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--skip-delete-schema`

🔰 Do not delete subject/schema

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


