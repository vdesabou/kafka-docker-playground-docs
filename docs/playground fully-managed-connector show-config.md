# playground fully-managed-connector show-config

🧰 Show current connector config that was applied  
  
use --force-rest-endpoint to get results with REST API /config endpoint (https://docs.confluent.io/cloud/current/api.html#tag/Connectors-(connectv1)/operation/getConnectv1ConnectorConfig)  


## Usage

```bash
playground fully-managed-connector show-config [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--force-rest-endpoint*

☢️ Force using REST API /config endpoint (https://docs.confluent.io/cloud/current/api.html#tag/Connectors-(connectv1)/operation/getConnectv1ConnectorConfig)


