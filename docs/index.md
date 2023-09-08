# playground

🧠 CLI for Kafka Docker Playground 🐳  
  
👉 Check documentation https://kafka-docker-playground.io/#/cli

| Attributes       | &nbsp;
|------------------|-------------
| Version:         | 1.0.0

## Usage

```bash
playground COMMAND
```

## Dependencies

#### *docker*

visit $(blue_underlined https://docs.docker.com/get-docker) to install

## == Commands ==

- [help](playground%20help) - Show help about a command

## Run commands

- [run](playground%20run) - 🕹️ Run any example, except for Confluent Cloud (in this case use run-ccloud command)
- [re-run](playground%20re-run) - ⚡ Simply re-run last example you ran with \<playground run\> or \<playground run-ccloud\>
- [run-ccloud](playground%20run-ccloud) - ⛅ Run any Confluent Cloud (ccloud) example
- [open](playground%20open) - 👐 When --file is not provided, simply open last example you ran with \<playground run\> or \<playground run-ccloud\>
- [stop](playground%20stop) - 🛑 Stop currently running example
- [open-docs](playground%20open-docs) - 🧑‍🎓 Open Confluent documentation of currently running example

## Repro commands

- [repro](playground%20repro) - 👷‍♂️ Reproduction model commands
- [export](playground%20repro%20export) - 📤 Export as tgz file uncommitted reproduction models from the folder of current reproduction model
- [import](playground%20repro%20import) - 📥 Import tgz file which was created with export command
- [bootstrap](playground%20repro%20bootstrap) - 🛠  Bootstrap reproduction model

## Kafka commands

- [get-docker-compose](playground%20get-docker-compose) - 🐋 Get docker-compose
- [get-properties](playground%20get-properties) - 📝 Get properties file from a container
- [get-all-schemas](playground%20get-all-schemas) - 🔰 Get all schemas versions for all subjects
- [get-jmx-metrics](playground%20get-jmx-metrics) - 🔢 Get JMX metrics from a component

## Debug commands

- [debug](playground%20debug) - 🐞 Debug commands
- [enable-remote-debugging](playground%20debug%20enable-remote-debugging) - ✨ Enable java remote debugging for container
- [testssl](playground%20debug%20testssl) - 🔐 Testing TLS/SSL encryption using https://testssl.sh/
- [thread-dump](playground%20debug%20thread-dump) - 🎯 Take a java thread dump
- [heap-dump](playground%20debug%20heap-dump) - 👻 Take a heap dump
- [tcp-dump](playground%20debug%20tcp-dump) - 🕵️‍♂️ Take a tcp dump (sniffing network)
- [block-traffic](playground%20debug%20block-traffic) - 🚫 Blocking traffic using iptables
- [flight-recorder](playground%20debug%20flight-recorder) - 🛩️ Record flight recorder
- [log-level](playground%20debug%20log-level) - 🧬 Set log level for any package

## Container commands

- [container](playground%20container) - 🐳 Container commands
- [recreate](playground%20container%20recreate) - 💫 Recreate container(s)
- [get-ip-addresses](playground%20container%20get-ip-addresses) - 🖥️  Get ip address of running containers
- [kill-all](playground%20container%20kill-all) - 💀 Kill all containers
- [logs](playground%20container%20logs) - 🕵️  Tail and follow container logs
- [ssh](playground%20container%20ssh) - 🛬 SSH into container
- [exec](playground%20container%20exec) - 🪄  Execute command in a container
- [restart](playground%20container%20restart) - 🔁 Restart a container
- [pause](playground%20container%20pause) - ⏸️  Pause a container
- [resume](playground%20container%20resume) - ⏯️  Resume a container
- [kill](playground%20container%20kill) - 🔫 Kill a container

## Topic commands

- [topic](playground%20topic) - 🗳 Topic commands
- [get-number-records](playground%20topic%20get-number-records) - 💯 Get number of records in a topic
- [display-consumer-offsets](playground%20topic%20display-consumer-offsets) - 📭 Display content of __consumer_offsets topic
- [describe](playground%20topic%20describe) - 🔬 Describe topic
- [set-schema-compatibility](playground%20topic%20set-schema-compatibility) - 🛡️ Change topic's schema compatibility
- [consume](playground%20topic%20consume) - 📥 Consume topic from beginning
- [produce](playground%20topic%20produce) - 📤 Produce to a topic
- [create](playground%20topic%20create) - 🆕 Create topic
- [delete](playground%20topic%20delete) - ❌ Delete topic

## Connector commands

- [ccloud-connector](playground%20ccloud-connector) - 🔗☁️ Fully Managed Connector commands
- [status](playground%20ccloud-connector%20status) - 🧩 Show status of all connectors
- [plugins](playground%20ccloud-connector%20plugins) - 🎨 Show all plugins installed
- [pause](playground%20ccloud-connector%20pause) - ⏸️  Pause connector
- [resume](playground%20ccloud-connector%20resume) - ⏯️  Resume connector
- [delete](playground%20ccloud-connector%20delete) - 🗑️  Delete connector
- [show-lag](playground%20ccloud-connector%20show-lag) - 🐢 Show lag of sink connector
- [show-config](playground%20ccloud-connector%20show-config) - 🧰 Show current connector config
- [show-config-parameters](playground%20ccloud-connector%20show-config-parameters) - 🔩 Show all possible configuration parameters of connector
- [create-or-update](playground%20ccloud-connector%20create-or-update) - 🧑‍🎨  Create or update connector
- [connector](playground%20connector) - 🔗 Connector commands
- [status](playground%20connector%20status) - 🧩 Show status of all connectors
- [plugins](playground%20connector%20plugins) - 🎨 Show all plugins installed
- [pause](playground%20connector%20pause) - ⏸️  Pause connector
- [versions](playground%20connector%20versions) - 🧞 Get current and latest version available on Confluent Hub for connector(s) used in example
- [restart](playground%20connector%20restart) - ♻️  Restart connector
- [resume](playground%20connector%20resume) - ⏯️  Resume connector
- [delete](playground%20connector%20delete) - 🗑️  Delete connector
- [show-lag](playground%20connector%20show-lag) - 🐢 Show lag of sink connector
- [show-config](playground%20connector%20show-config) - 🧰 Show current connector config
- [show-config-parameters](playground%20connector%20show-config-parameters) - 🔩 Show all possible configuration parameters of connector
- [log-level](playground%20connector%20log-level) - 🧬 Set connect log level
- [create-or-update](playground%20connector%20create-or-update) - 🧑‍🎨  Create or update connector

