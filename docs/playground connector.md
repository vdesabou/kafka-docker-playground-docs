# playground connector

🔗 Connector commands

## Usage

```bash
playground connector COMMAND
```

## == Commands ==

- [status](playground%20connector%20status) - 🧩 Show status of all connectors
- [oracle-cdc-xstream](playground%20connector%20oracle-cdc-xstream) - 🅾️ Specific Oracle CDC Xstream commands
- [offsets](playground%20connector%20offsets) - 💈 Handle source and sink connectors offsets
- [plugins](playground%20connector%20plugins) - 🎨 Show all connector plugins installed. You can also display transforms, converters and predicates using --all flag
- [pause](playground%20connector%20pause) - ⏸️  Pause connector
- [versions](playground%20connector%20versions) - 🧞 Get current and latest versions available on Confluent Hub for connector(s) used in example
- [sourcecode](playground%20connector%20sourcecode) - 🧑‍💻 open source code url for connector(s) used in example
- [enable-remote-debugging](playground%20connector%20enable-remote-debugging) - ✨ Enable java remote debugging for the connector.
- [disable-remote-debugging](playground%20connector%20disable-remote-debugging) - 🛑 Disable java remote debugging for the connector.
- [restart](playground%20connector%20restart) - ♻️  Restart connector
- [stop](playground%20connector%20stop) - 🛑 Stop connector (only available if CP \> 7.5)
- [resume](playground%20connector%20resume) - ⏯️  Resume connector
- [delete](playground%20connector%20delete) - 🗑️  Delete connector
- [show-lag](playground%20connector%20show-lag) - 🐢 Show lag of sink connector
- [show-config](playground%20connector%20show-config) - 🧰 Show current connector config that was applied
- [show-config-parameters](playground%20connector%20show-config-parameters) - 🔩 Show all possible configuration parameters of connector
- [display-metrics-api](playground%20connector%20display-metrics-api) - 〽️ Display metrics api for fully managed connector, see https://api.telemetry.confluent.cloud/docs/descriptors/datasets/cloud
- [display-metrics-api-with-grafana](playground%20connector%20display-metrics-api-with-grafana) - 📊 Display metrics api for fully managed connector in Grafana dashboard
- [select-config](playground%20connector%20select-config) - 🗜️ Easily select config from all possible configuration parameters of connector
- [snippets](playground%20connector%20snippets) - 🔌 useful snippets
- [open-docs](playground%20connector%20open-docs) - 🧑‍🎓 Open connector documentation of currently running conector(s)
- [log-level](playground%20connector%20log-level) - 🧬 Set connect log level
- [translate](playground%20connector%20translate) - 💱 Translate Self Managed Connector Plugin Configurations to Fully Managed Connector Plugin Configuration
- [connect-migration-utility](playground%20connector%20connect-migration-utility) - 🧩 Run Kafka Connector Migration Utility (see https://github.com/confluentinc/connect-migration-utility/) on running connect cluster
- [create-or-update](playground%20connector%20create-or-update) - 🧑‍🎨  Create or update connector
- [update](playground%20connector%20update) - 🛠️ Update connector configuration by opening current connector config in text editor set with playground config editor \<editor\> (default is code). Once file is saved, the new configuration is updated.

## Connect commands

- [logs](playground%20connector%20logs) - 🕵️  Tail and follow connect logs
- [open-ccloud-connector-in-browser](playground%20connector%20open-ccloud-connector-in-browser) - 🤖 Open Fully Managed connector in browser (Confluent Cloud dashboard)

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


