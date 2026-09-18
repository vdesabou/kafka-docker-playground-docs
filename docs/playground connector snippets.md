# playground connector snippets

🔌 useful snippets  
  
Prints ready-to-paste blocks of connector configuration: the key and  
value converter properties for a given format with --converter, and the  
dead letter queue properties with --dlq. Saves you from looking up the  
exact property names and the schema registry settings that go with them.

## Usage

```bash
playground connector snippets [OPTIONS]
```

## Options

#### *--converter CONVERTER*

🔌 Converter

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | avro, protobuf, json-schema, json, json-schema-enabled, string, bytearray

#### *--dlq*

💀 dlq

## Examples

```bash
playground connector snippets --converter avro --dlq

```


