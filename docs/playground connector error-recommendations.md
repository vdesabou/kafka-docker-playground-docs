# playground connector error-recommendations

💡 Show error recommendations for fully managed connectors  
  
Confluent Cloud analyses the failure stack trace of a failed fully  
managed or custom connector and suggests remediation steps. Nothing is  
returned for a healthy connector, or for one that only failed config  
validation: 'playground connector status' shows those errors.

## Usage

```bash
playground connector error-recommendations [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

## Examples

```bash
playground connector error-recommendations --connector MySinkConnector
```


