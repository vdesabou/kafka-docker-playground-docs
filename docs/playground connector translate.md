# playground connector translate

💱 Translate Self Managed Connector Plugin Configurations to Fully Managed Connector Plugin Configuration  
  
See https://docs.confluent.io/cloud/current/api.html#tag/Managed-Connector-Plugins-(connectv1)/operation/translateConnectv1ConnectorPlugin  
  
The connector example should be ran with --environment flag set to \<ccloud\>  


## Usage

```bash
playground connector translate [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector-plugin CONNECTOR-PLUGIN*

🔌 Connector plugin name  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes


