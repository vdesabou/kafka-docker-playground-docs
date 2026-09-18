# playground schema set-normalize

🧽 Set normalize at schema registry level  
  
With normalization on, the registry rewrites a schema into a canonical  
form before storing it, so two schemas that differ only in field order,  
whitespace or the way defaults are written get the same id instead of  
creating a new version every time.  
  
This applies to the whole registry, not to one subject. Turn it on when  
an example keeps registering a new version of an unchanged schema.  
  
See https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization

## Usage

```bash
playground schema set-normalize [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--value VALUE*

true or false

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | true, false


