# playground connector open-ccloud-connector-in-browser

🤖 Open Fully Managed connector in browser (Confluent Cloud dashboard)

Jumps straight to the connector's page in the Confluent Cloud console,  
resolving its lcc id for you, so you do not have to hunt through the  
environment and cluster menus.

☁️ Fully managed only (fully managed and custom connectors)

## Usage

```bash
playground connector open-ccloud-connector-in-browser [OPTIONS]
```

## Options

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--browser BROWSER`

🌎 browser name

Default browser from your system if not set

#### `--only-show-url`

🌐 Only show url

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--browser`

## Examples

```bash
playground connector open-ccloud-connector-in-browser --connector MySinkConnector
```

```bash
playground connector open-ccloud-connector-in-browser --connector MySinkConnector --only-show-url
```


