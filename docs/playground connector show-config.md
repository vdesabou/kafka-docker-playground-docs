# playground connector show-config

🧰 Show current connector config that was applied

use `--force-rest-endpoint` to get results with REST API /config endpoint (https://docs.confluent.io/platform/current/connect/references/restapi.html#get--connectors-(string-name)-config)

## Usage

```bash
playground connector show-config [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--force-rest-endpoint`

☢️ Force using REST API /config endpoint (https://docs.confluent.io/platform/current/connect/references/restapi.html#get--connectors-(string-name)-config)


