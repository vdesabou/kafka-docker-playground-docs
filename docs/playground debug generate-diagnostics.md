# playground debug generate-diagnostics

⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool  
  
⚠️ only connect and broker containers are supported for now  
  
see https://docs.confluent.io/platform/current/tools/diagnostics-tool.html#collect-diagnostics

## Usage

```bash
playground debug generate-diagnostics [OPTIONS]
```

## Options

#### *--container, -c CONTAINER*

🐳 Container name

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | connect

## Examples

```bash
playground debug generate-diagnostics
```

```bash
playground debug generate-diagnostics --container broker
```


