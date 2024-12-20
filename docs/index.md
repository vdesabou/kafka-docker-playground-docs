**playground**

🧠 CLI for Kafka Docker Playground 🐳  
  
👉 Check documentation https://kafka-docker-playground.io/#/cli

| Attributes       | &nbsp;
|------------------|-------------
| Version:         | 1.0.0

### Usage

```bash
playground [OPTIONS] COMMAND
```

### Dependencies

*docker*

visit https://docs.docker.com/get-docker to install

### == Commands ==

- [help](playground%20help) - Show help about a command
- [status](playground%20status) - 🗺️ Show a status
- [config](playground%20config) - ⚙️ Configure CLI

### Run commands

- [run](playground%20run) - 🕹️ Run any example !
- [re-run](playground%20re-run) - ⚡ Simply re-run last example you ran with \<playground run\>
- [history](playground%20history) - 🏰 Get an history of the examples which were run with run command and run it again
- [switch-ccloud](playground%20switch-ccloud) - 🌩️  Switch to ccloud environment.
- [switch-back](playground%20switch-back) - 💺  Switch back from previous environment before switch-ccloud was called.
- [update-version](playground%20update-version) - ✨ Update current confluent platform or connector(s) with new version(s)
- [open](playground%20open) - 👐 When --file is not provided, simply open last example you ran with \<playground run\>
- [stop](playground%20stop) - 🛑 Stop currently running example
- [remove-all-docker-images](playground%20remove-all-docker-images) - 🧨 Remove all docker images (including docker volumes)
- [cleanup-cloud-details](playground%20cleanup-cloud-details) - 🧼 playground is actively caching ccloud details (https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%8c%a4%ef%b8%8f-confluent-cloud-examples)
- [open-docs](playground%20open-docs) - 🧑‍🎓 Open Confluent documentation of currently running example
- [cleanup-cloud-resources](playground%20cleanup-cloud-resources) - 🧹 Cleanup cloud resources that were created by running examples from the playground

### Repro commands

- [repro](playground%20repro) - 👷‍♂️ Reproduction model commands
- [export](playground%20repro%20export) - 📤 Export as tgz file uncommitted reproduction models from the folder of current reproduction model
- [import](playground%20repro%20import) - 📥 Import tgz file which was created with export command
- [bootstrap](playground%20repro%20bootstrap) - 🛠  Bootstrap reproduction model, just run \<playground repro bootstrap\> !

### Kafka commands

- [get-docker-compose](playground%20get-docker-compose) - 🐋 Get docker-compose
- [get-jmx-metrics](playground%20get-jmx-metrics) - 🔢 Get JMX metrics from a container

### Schema commands

- [schema](playground%20schema) - 🔰 Schema commands
- [get](playground%20schema%20get) - 🔰 Get all schemas versions for specified subject (if --subject is not specified, all subjects will be used)
- [register](playground%20schema%20register) - ⏺️ Register a schema in specified subject
- [get-compatibility](playground%20schema%20get-compatibility) - 🛡️ Get subject-level compatibility
- [set-compatibility](playground%20schema%20set-compatibility) - 🛡️ Set subject-level compatibility
- [get-mode](playground%20schema%20get-mode) - 🔏 Get subject-level mode
- [set-mode](playground%20schema%20set-mode) - 🔏 Set subject-level mode
- [set-normalize](playground%20schema%20set-normalize) - 🧽 Set normalize at schema registry level
- [delete](playground%20schema%20delete) - 🧟 Delete schema

### TCP Proxy commands

- [tcp-proxy](playground%20tcp-proxy) - 🏚 Zazkia TCP Proxy commands
- [start](playground%20tcp-proxy%20start) - 💗 Start the TCP proxy and automatically replace connector config with zazkia hostname and port 49998
- [get-connections](playground%20tcp-proxy%20get-connections) - 🧲 Get Zazkia active TCP connections config and stats
- [delay](playground%20tcp-proxy%20delay) - ⏲️ Add milliseconds delay to service response.
- [break](playground%20tcp-proxy%20break) - 💔 Break sending the response to the client.
- [close-connection](playground%20tcp-proxy%20close-connection) - ❌ Close the Zazkia active TCP connections
- [close-all-connection-with-error](playground%20tcp-proxy%20close-all-connection-with-error) - 🧹 Close all Zazkia TCP connections which are in error state (close all with error button in Zazkia UI)
- [toggle-accept-connections](playground%20tcp-proxy%20toggle-accept-connections) - 🙅‍♂️ Change whether new connections can be accepted
- [toggle-reads-client](playground%20tcp-proxy%20toggle-reads-client) - ✅ Change whether reading data from the client is enabled.
- [toggle-reads-service](playground%20tcp-proxy%20toggle-reads-service) - ✅ Change whether reading data from the service is enabled.
- [toggle-writes-client](playground%20tcp-proxy%20toggle-writes-client) - ✅ Change whether writing data to the client is enabled.
- [toggle-writes-service](playground%20tcp-proxy%20toggle-writes-service) - ✅ Change whether reading data to the service is enabled.

### Tools commands

- [tools](playground%20tools) - 🧰 Tools commands
- [install-vscode-extension](playground%20tools%20install-vscode-extension) - 🪄 Install a slightly modified version of "Shell Script Command Completion" Visual Studio Code extension (https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)
- [read-avro-file](playground%20tools%20read-avro-file) - 🔖 Read provided avro file
- [read-parquet-file](playground%20tools%20read-parquet-file) - 🔖 Read provided parquet file
- [certs-create](playground%20tools%20certs-create) - 🔐 Generate keys and certificates used for SSL

### Debug commands

- [debug](playground%20debug) - 🐞 Debug commands
- [enable-remote-debugging](playground%20debug%20enable-remote-debugging) - ✨ Enable java remote debugging for container
- [testssl](playground%20debug%20testssl) - 🔐 Testing TLS/SSL encryption using https://testssl.sh/
- [generate-diagnostics](playground%20debug%20generate-diagnostics) - ⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool
- [thread-dump](playground%20debug%20thread-dump) - 🎯 Take a java thread dump
- [heap-dump](playground%20debug%20heap-dump) - 👻 Take a heap dump
- [tcp-dump](playground%20debug%20tcp-dump) - 🕵️‍♂️ Take a tcp dump (sniffing network)
- [block-traffic](playground%20debug%20block-traffic) - 🚫 Blocking traffic using iptables
- [java-debug](playground%20debug%20java-debug) - 🤎 JVM arguments for SSL, Kerberos or Class Loading
- [flight-recorder](playground%20debug%20flight-recorder) - 🛩️ Record flight recorder
- [log-level](playground%20debug%20log-level) - 🧬 Set log level for any package

### Container commands

- [container](playground%20container) - 🐳 Container commands
- [get-properties](playground%20container%20get-properties) - 📝 Get properties file from a container
- [recreate](playground%20container%20recreate) - 💫 Recreate container(s)
- [get-ip-addresses](playground%20container%20get-ip-addresses) - 🖥️  Get ip address of running containers
- [kill-all](playground%20container%20kill-all) - 💀 Kill all containers
- [logs](playground%20container%20logs) - 🕵️  Tail and follow container logs
- [ssh](playground%20container%20ssh) - 🛬 SSH into container
- [change-jdk](playground%20container%20change-jdk) - 🤎 Change java JDK version using Azul JDK (https://www.azul.com/downloads/#downloads-table-zulu)
- [exec](playground%20container%20exec) - 🪄  Execute command in a container
- [restart](playground%20container%20restart) - 🔁 Restart a container
- [pause](playground%20container%20pause) - ⏸️  Pause a container
- [resume](playground%20container%20resume) - ⏯️  Resume a container
- [kill](playground%20container%20kill) - 🔫 Kill a container
- [set-environment-variables](playground%20container%20set-environment-variables) - 📦  Set environment variable(s) for a container

### Topic commands

- [topic](playground%20topic) - 🗳 Topic commands
- [get-number-records](playground%20topic%20get-number-records) - 💯 Get number of records in a topic
- [display-consumer-offsets](playground%20topic%20display-consumer-offsets) - 📭 Display content of __consumer_offsets topic
- [list](playground%20topic%20list) - 🔘 List topics
- [describe](playground%20topic%20describe) - 🔬 Describe topic
- [set-schema-compatibility](playground%20topic%20set-schema-compatibility) - 🛡️ Change topic's schema compatibility
- [consume](playground%20topic%20consume) - 📥 Consume topic from beginning
- [produce](playground%20topic%20produce) - 📤 Produce to a topic
- [create](playground%20topic%20create) - 🆕 Create topic
- [delete](playground%20topic%20delete) - ❌ Delete topic and associated schema/subject if applicable
- [alter](playground%20topic%20alter) - 🪛 Alter topic config

### Connector-Plugin commands

- [connector-plugin](playground%20connector-plugin) - 🔌 Connector-plugin commands
- [search-jar](playground%20connector-plugin%20search-jar) - ☕ List jars for a connector plugin from confluent hub https://www.confluent.io/hub/ Search for specific class and display method signatures
- [versions](playground%20connector-plugin%20versions) - 💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/

### Connector commands

- [connector](playground%20connector) - 🔗 Connector commands
- [status](playground%20connector%20status) - 🧩 Show status of all connectors
- [offsets](playground%20connector%20offsets) - 💈 Handle source and sink connectors offsets
- [plugins](playground%20connector%20plugins) - 🎨 Show all connector plugins installed. You can also display transforms, converters and predicates using --all flag
- [pause](playground%20connector%20pause) - ⏸️  Pause connector
- [versions](playground%20connector%20versions) - 🧞 Get current and latest versions available on Confluent Hub for connector(s) used in example
- [restart](playground%20connector%20restart) - ♻️  Restart connector
- [stop](playground%20connector%20stop) - 🛑 Stop connector (only available if CP \> 7.5)
- [resume](playground%20connector%20resume) - ⏯️  Resume connector
- [delete](playground%20connector%20delete) - 🗑️  Delete connector
- [show-lag](playground%20connector%20show-lag) - 🐢 Show lag of sink connector
- [show-config](playground%20connector%20show-config) - 🧰 Show current connector config that was applied
- [show-config-parameters](playground%20connector%20show-config-parameters) - 🔩 Show all possible configuration parameters of connector
- [select-config](playground%20connector%20select-config) - 🗜️ Easily select config from all possible configuration parameters of connector
- [snippets](playground%20connector%20snippets) - 🔌 useful snippets
- [open-docs](playground%20connector%20open-docs) - 🧑‍🎓 Open connector documentation of currently running conector(s)
- [log-level](playground%20connector%20log-level) - 🧬 Set connect log level
- [logs](playground%20connector%20logs) - 🕵️  Tail and follow connect logs
- [open-ccloud-connector-in-browser](playground%20connector%20open-ccloud-connector-in-browser) - 🤖 Open Fully Managed connector in browser (Confluent Cloud dashboard)
- [create-or-update](playground%20connector%20create-or-update) - 🧑‍🎨  Create or update connector
- [update](playground%20connector%20update) - 🛠️ Update connector configuration by opening current connector config in text editor set with playground config editor \<editor\> (default is code). Once file is saved, the new configuration is updated.

### EC2 commands

- [ec2](playground%20ec2) - ✨ Create and manage AWS EC2 instances (using Cloud Formation) to run kafka-docker-playground
- [create](playground%20ec2%20create) - 👷 Create kafka-docker-playground EC2 instance using AWS Cloud Formation
- [delete](playground%20ec2%20delete) - ❌ Delete an EC2 instance created with Cloud Formation
- [open](playground%20ec2%20open) - 👨‍💻 Open an EC2 instance using Visual Studio code
- [list](playground%20ec2%20list) - 🔘 List all EC2 instance
- [stop](playground%20ec2%20stop) - 🔴 Stop an EC2 instance
- [start](playground%20ec2%20start) - 🟢 Start an EC2 instance
- [sync-repro-folder](playground%20ec2%20sync-repro-folder) - ↔️ Synchronize reproduction-models folder bewteen local and ec2 instance

## Options

#### *--vvv, -v*

🐛 set verbose output (set -x)  
  
❗ it can print sensitive information ❗  


#### *--output-level, -o LEVEL*

❕Log level used by all commands  
  
Default is INFO (all INFO, WARN and ERROR will be printed in command output)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | INFO, WARN, ERROR


