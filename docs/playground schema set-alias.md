# playground schema set-alias

🔯 Set a subject alias  
  
Makes --alias point at --subject, so a client asking for the alias gets  
the real subject's schemas. That is how you let a consumer keep its own  
subject name while the data actually lives under another one, typically  
after a topic rename or a migration between registries.  
  
CP 7.4.1 or higher is required to have this feature.  
  
See https://docs.confluent.io/platform/current/schema-registry/fundamentals/index.html#subject-aliases

## Usage

```bash
playground schema set-alias [OPTIONS]
```

## Options

#### *--subject SUBJECT*

📛 Subject name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--alias ALIAS*

🔯 Alias name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--verbose, -v*

🐞 Show command being ran.


