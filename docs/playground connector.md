# playground connector

🔗 Connector commands

## Usage

```bash
playground connector COMMAND
```

## == Commands ==

- [status](playground%20connector%20status) - 🧩 Show status of all connectors
- [plugins](playground%20connector%20plugins) - 🎨 Show all plugins installed
- [pause](playground%20connector%20pause) - ⏸️  Pause connector
- [versions](playground%20connector%20versions) - 🧞 Get current and latest version available on Confluent Hub for connector(s) used in example
- [restart](playground%20connector%20restart) - ♻️  Restart connector
- [stop](playground%20connector%20stop) - 🛑 Stop connector (only available if CP \> 7.5 )
- [resume](playground%20connector%20resume) - ⏯️  Resume connector
- [delete](playground%20connector%20delete) - 🗑️  Delete connector
- [show-lag](playground%20connector%20show-lag) - 🐢 Show lag of sink connector
- [show-config](playground%20connector%20show-config) - 🧰 Show current connector config
- [show-config-parameters](playground%20connector%20show-config-parameters) - 🔩 Show all possible configuration parameters of connector
- [search-jar](playground%20connector%20search-jar) - 🔌 List jars for a connector plugin from confluent hub https://www.confluent.io/hub/ Search for specific class and display method signatures
- [log-level](playground%20connector%20log-level) - 🧬 Set connect log level
- [create-or-update](playground%20connector%20create-or-update) - 🧑‍🎨  Create or update connector

## Examples

```bash
playground connector status
```

```bash
playground connector status --json
```

```bash
playground connector resume --connector <connector-name>
```

```bash
playground connector pause -c <connector-name>
```

```bash
playground connector delete -c <connector-name>
```


