# playground connector translate

💱 Translate Self Managed Connector Plugin Configurations to Fully Managed Connector Plugin Configuration  
  
Takes the configuration of the self managed connector that is running  
and asks Confluent Cloud what the fully managed equivalent looks like.  
Properties are renamed, some disappear, some have no equivalent at all,  
and this tells you which before you promise a customer a migration.  
  
Only translates the configuration. To actually move the connector along  
with its offsets, use 'playground connector connect-migration-utility'.  
  
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


