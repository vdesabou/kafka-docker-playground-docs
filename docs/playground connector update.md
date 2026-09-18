# playground connector update

🛠️ Update connector configuration by opening current connector config in text editor set with playground config editor \<editor\> (default is code). Once file is saved, the new configuration is updated.  
  
The quickest loop to try a configuration change: edit, save, close, and  
the connector is updated. Nothing is applied if you close the file  
without saving.

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | edit, alter

## Usage

```bash
playground connector update [OPTIONS]
```

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

## Examples

```bash
playground connector update -c filestream-sink

```


