# playground connector

🔗 Connector commands  
  
Everything you would otherwise do with curl on the Connect REST API, with  
the right host, port and credentials already figured out. The same  
commands work whether the connector is self managed in the connect  
container or fully managed in Confluent Cloud.  
  
🔍 Look at what is running  
  status                  is it RUNNING, and if not, the full stack trace  
  error-recommendations   suggested fixes for a failed fully managed connector  
  show-config             the configuration actually applied  
  logs                    tail connect logs, filtered and followed  
  show-lag                consumer lag of a sink, until it reaches zero  
  offsets get             where the connector is reading or writing  
  
🛠️ Change it  
  create-or-update        create it, or apply a new config, from stdin  
  update                  edit the running config in your editor  
  pause / resume / stop / restart / delete  
  offsets alter / reset   rewind or fast-forward a connector  
  
🧑‍🔬 Understand it  
  show-config-parameters  every parameter the plugin accepts  
  select-config           pick parameters interactively  
  versions                installed version vs latest on Confluent Hub  
  sourcecode              open the source on GitHub, or diff two versions  
  open-docs               open the Confluent documentation  
  snippets                ready-to-paste converter and dlq config  
  
🐞 Dig deeper  
  log-level               raise connect log level for this connector  
  enable-remote-debugging attach a java debugger to the connector code  
  translate               self managed config to fully managed config  
  
Without --connector, commands apply to every connector of the example,  
which is usually what you want since most examples run only one.

## Usage

```bash
playground connector COMMAND
```

## == Commands ==

- [status](playground%20connector%20status) - 🧩 Show status of all connectors
- [error-recommendations](playground%20connector%20error-recommendations) - 💡 Show error recommendations for fully managed connectors
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
- [display-metrics-api](playground%20connector%20display-metrics-api) - 〽️ Display metrics api for fully managed connector
- [display-metrics-api-with-grafana](playground%20connector%20display-metrics-api-with-grafana) - 📊 Display metrics api for fully managed connector in Grafana dashboard
- [select-config](playground%20connector%20select-config) - 🗜️ Easily select config from all possible configuration parameters of connector
- [snippets](playground%20connector%20snippets) - 🔌 useful snippets
- [open-docs](playground%20connector%20open-docs) - 🧑‍🎓 Open connector documentation of currently running connector(s)
- [log-level](playground%20connector%20log-level) - 🧬 Set connect log level
- [translate](playground%20connector%20translate) - 💱 Translate Self Managed Connector Plugin Configurations to Fully Managed Connector Plugin Configuration
- [connect-migration-utility](playground%20connector%20connect-migration-utility) - 🧩 Run Kafka Connector Migration Utility (see https://github.com/confluentinc/connect-migration-utility/) on running connect cluster
- [create-or-update](playground%20connector%20create-or-update) - 🧑‍🎨  Create or update connector
- [update](playground%20connector%20update) - 🛠️ Update connector configuration by opening current connector config in text editor set with playground config editor \<editor\> (default is code). Once file is saved, the new configuration is updated.

## Connect commands

- [logs](playground%20connector%20logs) - 🕵️  Tail and follow connect logs
- [open-ccloud-connector-in-browser](playground%20connector%20open-ccloud-connector-in-browser) - 🤖 Open Fully Managed connector in browser (Confluent Cloud dashboard)
- [display-leader-name](playground%20connector%20display-leader-name) - 👑 Display Connect Worker leader name using JMX MBean leader-name from kafka.connect:type=connect-worker-rebalance-metrics

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


