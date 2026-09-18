# playground schema validate-new-schemas

🩺 Validate new schemas (default is true since CP 8.2.0)  
  
Controls whether the registry checks a schema is well formed before  
accepting it. Since CP 8.2.0 this is on by default, and Avro 1.12 added  
strict namespace validation, so schemas that a customer registered years  
ago can now be rejected on a newer version.  
  
Set it to false to reproduce what that customer had, or to let a legacy  
schema through while you investigate. It applies to the whole registry.  
  
See https://docs.confluent.io/cloud/current/sr/fundamentals/serdes-develop/index.html#supported-formats:~:text=Strict%20namespace%20validation%20with%20Avro%20version%201.12

## Usage

```bash
playground schema validate-new-schemas [OPTIONS]
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


