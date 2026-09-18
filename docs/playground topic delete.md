# playground topic delete

❌ Delete topic and associated schema/subject if applicable  
  
Also removes the key and value subjects from the schema registry,  
which is what you usually want: a topic re-created with a leftover  
subject keeps the old compatibility rules and the old schema history.  
Keep them with --skip-delete-schema.  
  
A regex is accepted, matched in full, to clean up a family of topics  
at once.

## Usage

```bash
playground topic delete [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--topic, -t TOPIC*

🗳 Topic name or regex pattern (full match)  
  
Examples: my-topic, my-topic-.*

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--skip-delete-schema*

🔰 Do not delete subject/schema


