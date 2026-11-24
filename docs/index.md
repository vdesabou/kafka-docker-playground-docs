**playground**

🧠 CLI for Kafka Docker Playground 🐳

👉 Check documentation https://kafka-docker-playground.io/#/cli

🎬 Bite size sessions (short videos): https://kafka-docker-playground.io/#/sessions  
🍪 Deep dives (one family of commands each): https://kafka-docker-playground.io/#/deep-dives  
🧭 Which command answers my question? playground find-command "`<question>`"

| Attributes       | &nbsp;
|------------------|-------------
| Version:         | 1.0.0

### Usage

```bash
playground [OPTIONS] COMMAND
```

### Environment Variables

#### `PLAYGROUND_CLUSTER`

🌍 Cluster used by the topic, consumer-group, connector, schema, broker and quota commands in an mdc-\* environment (us or europe) when `--cluster` is not set

### Commands

- [config](playground%20config) - ⚙️ Configure CLI
  - [account-check-before-run](playground%20config%20account-check-before-run) - when running an example of a provider (gcp, azure, aws, snowflake, salesforce, servicenow, databricks, zendesk, jira, marketo, clickhouse, couchbase, mongodb-atlas, pagerduty), call playground account `<provider>` check first: a login that does not work stops the run in a few seconds instead of failing minutes later. True by default, never done in CI.
  - [check-and-update-repo-version](playground%20config%20check-and-update-repo-version) - when running an example, always check if repo version is older than 3 days, if disabled, it will skip this check.
  - [cleanup-ccloud-resources-after-run](playground%20config%20cleanup-ccloud-resources-after-run) - 🧹 delete the Confluent Cloud resources left by the last ccloud example
  - [clipboard](playground%20config%20clipboard) - copy to clipboard connector config (only working on MacOS)
  - [container-kill-all-before-run](playground%20config%20container-kill-all-before-run) - when running an example, always call playground container kill-all first. If set to false, it will call playground stop instead.
  - [display-last-updated-connector-plugins](playground%20config%20display-last-updated-connector-plugins) - 🆕 at the end of a self-managed connector run, list the connector plugins released recently on Confluent Hub (default false)
  - [display-last-updated-connector-plugins-days](playground%20config%20display-last-updated-connector-plugins-days) - 📅 number of days to look back for display-last-updated-connector-plugins
  - [display-last-updated-connector-plugins-vendor](playground%20config%20display-last-updated-connector-plugins-vendor) - 🏢 vendor of the connector plugins listed by display-last-updated-connector-plugins
  - [editor](playground%20config%20editor) - editor to use to open files
  - [folder_zip_or_jar](playground%20config%20folder_zip_or_jar) - 📂 list of folders where to search for zip or jar
  - [open-ccloud-connector-in-browser](playground%20config%20open-ccloud-connector-in-browser) - when running a fully managed connector example, it opens the connector in browser
    - [automatically](playground%20config%20open-ccloud-connector-in-browser%20automatically) - automatically open the connector in browser
    - [browser](playground%20config%20open-ccloud-connector-in-browser%20browser) - browser to use
  - [open-diagnose-report-on-failure](playground%20config%20open-diagnose-report-on-failure) - 🩺 open the HTML report when a connector fails (default true)
  - [open-grafana-in-browser](playground%20config%20open-grafana-in-browser) - when running an example with `--enable-jmx-grafana` flag, it opens grafana in browser
    - [automatically](playground%20config%20open-grafana-in-browser%20automatically) - automatically open grafana in browser
    - [browser](playground%20config%20open-grafana-in-browser%20browser) - browser to use
  - [run-log](playground%20config%20run-log) - 📄 write a masked log of each `playground run` (default true)
  - [run-log-folder](playground%20config%20run-log-folder) - 🗂️ folder of the run logs
- [doctor](playground%20doctor) - 🩺 Check that the container engine is ready for the playground
- [help](playground%20help) - Show help about a command
- [status](playground%20status) - 🗺️ Show a status

### Accounts commands

- [account](playground%20account) - ☁️ Set up and check the accounts the examples run against
  - [aws](playground%20account%20aws) - ☁️ Set up the AWS credentials of the AWS examples, and check them
    - [check](playground%20account%20aws%20check) - 🩺 Check the AWS credentials of the AWS examples
    - [setup](playground%20account%20aws%20setup) - 🛠️ Validate and store the AWS credentials of the AWS examples
  - [azure](playground%20account%20azure) - ☁️ Set up an Azure subscription for the Azure examples, and check it
    - [check](playground%20account%20azure%20check) - 🩺 Check that the stored Azure service principal works for the Azure examples
    - [setup](playground%20account%20azure%20setup) - 🛠️ Configure an Azure subscription for the Azure examples
  - [ccloud](playground%20account%20ccloud) - 🌤️ Set up your own Confluent Cloud clusters for the fully managed examples, and check them
    - [check](playground%20account%20ccloud%20check) - 🩺 Check the environment, clusters and API keys of the fully managed examples
    - [setup](playground%20account%20ccloud%20setup) - 🏗️ Create (or complete) your personal environment and clusters, and store them in a secrets profile
  - [clickhouse](playground%20account%20clickhouse) - 🏠 Set up and check the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
    - [check](playground%20account%20clickhouse%20check) - 🩺 Check the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
    - [setup](playground%20account%20clickhouse%20setup) - 🛠️ Validate and store the ClickHouse Cloud account of the ClickHouse examples (connect-clickhouse-sink, fm-clickhouse-sink)
  - [couchbase](playground%20account%20couchbase) - 🛋️ Set up and check the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
    - [check](playground%20account%20couchbase%20check) - 🩺 Check the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
    - [setup](playground%20account%20couchbase%20setup) - 🛠️ Validate and store the Couchbase Capella account of the Couchbase examples (fm-couchbase-sink, fm-couchbase-source)
  - [databricks](playground%20account%20databricks) - ☁️ Set up the Databricks workspace of the Databricks examples, and check it
    - [check](playground%20account%20databricks%20check) - 🩺 Check the Databricks workspace of the Databricks examples
    - [setup](playground%20account%20databricks%20setup) - 🛠️ Validate and store the Databricks workspace of the Databricks examples
  - [gcp](playground%20account%20gcp) - ☁️ Set up a Google Cloud project for the GCP examples, and check it
    - [check](playground%20account%20gcp%20check) - 🩺 Check that the stored GCP key works for the GCP examples
    - [setup](playground%20account%20gcp%20setup) - 🛠️ Configure a Google Cloud project for the GCP examples
  - [jira](playground%20account%20jira) - 📋 Set up and check the Jira account of the Jira examples (connect-jira-source, fm-jira-source)
    - [check](playground%20account%20jira%20check) - 🩺 Check the Jira account of the Jira examples (connect-jira-source, fm-jira-source)
    - [setup](playground%20account%20jira%20setup) - 🛠️ Validate and store the Jira account of the Jira examples (connect-jira-source, fm-jira-source)
  - [marketo](playground%20account%20marketo) - 📣 Set up and check the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)
    - [check](playground%20account%20marketo%20check) - 🩺 Check the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)
    - [setup](playground%20account%20marketo%20setup) - 🛠️ Validate and store the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)
  - [mongodb-atlas](playground%20account%20mongodb-atlas) - 🍃 Set up and check the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)
    - [check](playground%20account%20mongodb-atlas%20check) - 🩺 Check the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)
    - [setup](playground%20account%20mongodb-atlas%20setup) - 🛠️ Validate and store the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)
  - [pagerduty](playground%20account%20pagerduty) - 🛎️ Set up and check the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)
    - [check](playground%20account%20pagerduty%20check) - 🩺 Check the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)
    - [setup](playground%20account%20pagerduty%20setup) - 🛠️ Validate and store the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)
  - [salesforce](playground%20account%20salesforce) - ☁️ Set up a Salesforce org for the Salesforce examples, and check it
    - [check](playground%20account%20salesforce%20check) - 🩺 Check that the stored Salesforce credentials work
    - [setup](playground%20account%20salesforce%20setup) - 🛠️ Configure a Salesforce org for the Salesforce examples
  - [servicenow](playground%20account%20servicenow) - ☁️ Set up the ServiceNow instance of the ServiceNow examples, and check it
    - [check](playground%20account%20servicenow%20check) - 🩺 Check the ServiceNow instance of the ServiceNow examples
    - [setup](playground%20account%20servicenow%20setup) - 🛠️ Validate and store the ServiceNow instance of the ServiceNow examples
  - [snowflake](playground%20account%20snowflake) - ❄️ Set up the Snowflake account of the Snowflake examples, and check it
    - [check](playground%20account%20snowflake%20check) - 🩺 Check that the stored Snowflake login works for the Snowflake examples
    - [setup](playground%20account%20snowflake%20setup) - 🛠️ Validate and store the Snowflake login of the Snowflake examples
  - [zendesk](playground%20account%20zendesk) - 🎫 Set up and check the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)
    - [check](playground%20account%20zendesk%20check) - 🩺 Check the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)
    - [setup](playground%20account%20zendesk%20setup) - 🛠️ Validate and store the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)

### Analyze commands

- [analyze](playground%20analyze) - 🔎 Analyze commands
  - [flight-recorder](playground%20analyze%20flight-recorder) - 🛩️ Analyze a Java Flight Recorder recording: where the time of the connector tasks goes
  - [gc-logs](playground%20analyze%20gc-logs) - 📈 Analyze JVM Garbage Collection logs
  - [heap-dump](playground%20analyze%20heap-dump) - 🔬 Analyze a heap dump with Eclipse Memory Analyzer (MAT), run headless in Docker
  - [jscissors](playground%20analyze%20jscissors) - ✂️ Analyze a jscissors trace: what the traced methods did, call by call
  - [logs](playground%20analyze%20logs) - 🔥 Show a digest of ERROR/FATAL records found in log files, folders or zip bundles
  - [oracle-xstream-report](playground%20analyze%20oracle-xstream-report) - 🅾️ Analyze Oracle XStream CDC diagnostics reports (orclcdc_diag.sql)
  - [tcp-dump](playground%20analyze%20tcp-dump) - 🦈 Analyze a network capture (.pcap, .pcapng): refused and reset connections, retransmissions, TLS alerts, DNS errors, Kafka and HTTP errors and response times
  - [thread-dump](playground%20analyze%20thread-dump) - 🧵 Analyze java thread dumps: deadlocks, lock contention, stuck and CPU-hungry threads
  - [watch](playground%20analyze%20watch) - 👀 Watch a folder (default: ~/Downloads) and analyze every new log file, bundle, dump, capture or report, report opened in the browser

### Ansible commands

- [ansible](playground%20ansible) - 🅰️ cp-ansible commands (ansible and ansible-sasl-ssl environments)
  - [add-host](playground%20ansible%20add-host) - 🖥️ Add hosts to the running cluster
  - [inventory](playground%20ansible%20inventory) - 📋 Read and change the inventory of the ansible environment
    - [delete](playground%20ansible%20inventory%20delete) - 🗑️ Remove a yq path from the inventory, and print the change
    - [get](playground%20ansible%20inventory%20get) - 🔎 Display the inventory, or the value of a yq path
    - [set](playground%20ansible%20inventory%20set) - ✏️ Set the value of a yq path, and print the change
  - [playbook](playground%20ansible%20playbook) - ▶️ Run the playbook again on the hosts
  - [upgrade](playground%20ansible%20upgrade) - ⬆️ Upgrade (or downgrade) Confluent Platform with cp-ansible

### CFK commands

- [cfk](playground%20cfk) - ☸️ Confluent for Kubernetes commands (cfk and cfk-rbac environments)
  - [kraft-migration](playground%20cfk%20kraft-migration) - 🚚 ZooKeeper to KRaft migration with a KRaftMigrationJob
    - [finalize](playground%20cfk%20kraft-migration%20finalize) - 🏁 Finalize the migration (irreversible) and wait for COMPLETE
    - [release-lock](playground%20cfk%20kraft-migration%20release-lock) - 🔓 Release the locks of the migration on the CRs
    - [start](playground%20cfk%20kraft-migration%20start) - 🚚 Start the migration and wait for DUAL-WRITE
    - [status](playground%20cfk%20kraft-migration%20status) - 🔎 Phase, sub-phase, the CRs, the locks and what to do next
  - [operator](playground%20cfk%20operator) - ☸️ The CFK operator
    - [upgrade](playground%20cfk%20operator%20upgrade) - ⬆️ Upgrade the CFK operator, with the CFK upgrade procedure
  - [patch](playground%20cfk%20patch) - 🩹 Change a custom resource and wait for CFK to roll it
  - [roll](playground%20cfk%20roll) - 🔁 Restart the pods of a custom resource, the way CFK supports
  - [upgrade](playground%20cfk%20upgrade) - ⬆️ Move every custom resource to another Confluent Platform version

### Cleanup commands

- [cleanup-cloud-details](playground%20cleanup-cloud-details) - 🧼 playground is actively caching ccloud details (https://kafka-docker-playground.io/#/how-to-use?id=%f0%9f%8c%a4%ef%b8%8f-confluent-cloud-examples)
- [docker-cleanup](playground%20docker-cleanup) - 🧽 Free the disk of the container engine every week, automatically: old Confluent Platform images, dangling images, old build cache
  - [disable](playground%20docker-cleanup%20disable) - 🛑 Remove the weekly cleanup schedule
  - [enable](playground%20docker-cleanup%20enable) - 🧽 Schedule the weekly cleanup, then show what it would remove now
  - [run](playground%20docker-cleanup%20run) - 🧽 Free the disk of the container engine now, as the weekly job does
  - [status](playground%20docker-cleanup%20status) - 🔎 Is the weekly cleanup scheduled, when, and what did its last runs free
- [forgotten-environment](playground%20forgotten-environment) - 🔔 Get a macOS notification every evening when a local environment was left running with nobody using it. It never stops anything
  - [disable](playground%20forgotten-environment%20disable) - 🛑 Remove the schedule of the forgotten environment check
  - [enable](playground%20forgotten-environment%20enable) - 🔔 Schedule the evening check of a forgotten local environment, then run it once now
  - [run](playground%20forgotten-environment%20run) - 🔔 Check now whether a local environment runs with nobody using it, as the scheduled job does
  - [status](playground%20forgotten-environment%20status) - 🔎 Is the forgotten environment check scheduled, when, and what did its last checks find
- [remove-all-docker-images](playground%20remove-all-docker-images) - 🧨 Remove all docker images (including docker volumes)
- [remove-cp-docker-images](playground%20remove-cp-docker-images) - 🧹 Remove the Confluent Platform docker images of the versions you no longer use (a table of the versions installed locally, then a selection)

### Cloud Resources commands

- [cloud-resources](playground%20cloud-resources) - ☁️ What the playground left behind in your cloud accounts, what it costs, and cleaning it up
  - [aws](playground%20cloud-resources%20aws) - ☁️ What is still running in AWS, and what it costs
    - [costs](playground%20cloud-resources%20aws%20costs) - 💰 Show aws costs
    - [costs-history](playground%20cloud-resources%20aws%20costs-history) - 👛  Retrieve aws costs for each month since last year
    - [list](playground%20cloud-resources%20aws%20list) - 📋 List all active resources
  - [azure](playground%20cloud-resources%20azure) - ☁️ What is still running in Azure, and what it costs
    - [costs](playground%20cloud-resources%20azure%20costs) - 💰 Show azure costs
    - [costs-history](playground%20cloud-resources%20azure%20costs-history) - 👛  Retrieve azure costs for each month since last year
    - [list](playground%20cloud-resources%20azure%20list) - 📋 List all active resources
  - [ccloud](playground%20cloud-resources%20ccloud) - ☁️ What is still running in Confluent Cloud, and what it costs
    - [costs](playground%20cloud-resources%20ccloud%20costs) - 💰  Retrieve ccloud costs for a range of dates
    - [costs-history](playground%20cloud-resources%20ccloud%20costs-history) - 👛  Retrieve ccloud costs for each month since last year
    - [list](playground%20cloud-resources%20ccloud%20list) - 📋 List what the playground left running for you in Confluent Cloud, across the whole organization
  - [cleanup](playground%20cloud-resources%20cleanup) - 🧹 Cleanup cloud resources that were created by running examples from the playground
  - [cost-reminder](playground%20cloud-resources%20cost-reminder) - 💸 Every week, a notification when your cloud spend went above a threshold, or something billed is still running for you. Read-only, it never deletes anything
    - [disable](playground%20cloud-resources%20cost-reminder%20disable) - 🛑 Remove the weekly cost reminder schedule
    - [enable](playground%20cloud-resources%20cost-reminder%20enable) - 💸 Schedule the weekly cost reminder, then run it once now
    - [run](playground%20cloud-resources%20cost-reminder%20run) - 💸 Check now what your clouds cost over the last `--days` days and what still runs for you, as the weekly job does
    - [status](playground%20cloud-resources%20cost-reminder%20status) - 🔎 Is the weekly cost reminder scheduled, when, and what did its last runs find
  - [nightly-cleanup](playground%20cloud-resources%20nightly-cleanup) - 🌙 Delete what your examples left running in Confluent Cloud (and AWS, GCP, Azure with `--resource`), every night, automatically
    - [disable](playground%20cloud-resources%20nightly-cleanup%20disable) - 🛑 Remove the nightly cleanup schedule
    - [enable](playground%20cloud-resources%20nightly-cleanup%20enable) - 🌙 Schedule the nightly cleanup, then show what tonight's run would delete
    - [status](playground%20cloud-resources%20nightly-cleanup%20status) - 🔎 Is the nightly cleanup scheduled, at what time, and what did its last runs do

### Codespace commands

- [codespace](playground%20codespace) - ☁️ Create and manage GitHub Codespaces to run kafka-docker-playground
  - [create](playground%20codespace%20create) - 👷 Create a GitHub Codespace of kafka-docker-playground, then open it
  - [delete](playground%20codespace%20delete) - ❌ Delete a codespace
  - [list](playground%20codespace%20list) - 🔘 List your kafka-docker-playground codespaces
  - [open](playground%20codespace%20open) - 👨‍💻 Open a codespace in Visual Studio Code
  - [push-secrets](playground%20codespace%20push-secrets) - 🔐 Send the secrets store to a codespace
  - [ssh](playground%20codespace%20ssh) - 🐚 Open a shell in a codespace, or run one command in it
  - [start](playground%20codespace%20start) - 🟢 Start a codespace
  - [stop](playground%20codespace%20stop) - 🔴 Stop a codespace
  - [sync-repro-folder](playground%20codespace%20sync-repro-folder) - ↔️ Synchronize reproduction-models folder between local and a codespace
    - [codespace-to-local](playground%20codespace%20sync-repro-folder%20codespace-to-local) - 👈 Sync a codespace reproduction-models folder to local
    - [local-to-codespace](playground%20codespace%20sync-repro-folder%20local-to-codespace) - 👉 Sync local reproduction-models folder to a codespace

### Connector commands

- [connector](playground%20connector) - 🔗 Connector commands
  - [benchmark](playground%20connector%20benchmark) - 🏎️ Benchmark the throughput of a connector
  - [connect-migration-utility](playground%20connector%20connect-migration-utility) - 🧩 Run Kafka Connector Migration Utility (see https://github.com/confluentinc/connect-migration-utility/) on running connect cluster
    - [discovery](playground%20connector%20connect-migration-utility%20discovery) - 👨‍🔬 Discover connectors in the local connect cluster and export their configurations to files
    - [migrate](playground%20connector%20connect-migration-utility%20migrate) - 🪄 Migrate discovered connectors to fully managed connectors
  - [convert](playground%20connector%20convert) - 🔄 Convert a connector config from the format a customer sent to another one
  - [create-or-update](playground%20connector%20create-or-update) - 🧑‍🎨  Create or update connector
  - [delete](playground%20connector%20delete) - 🗑️  Delete connector
  - [diagnose](playground%20connector%20diagnose) - 🩺 Diagnose a connector in one call: status, errors and progress
  - [diff](playground%20connector%20diff) - 🔀 Diff the config of a running connector with another config
  - [disable-remote-debugging](playground%20connector%20disable-remote-debugging) - 🛑 Disable java remote debugging for the connector.
  - [display-leader-name](playground%20connector%20display-leader-name) - 👑 Display Connect Worker leader name using JMX MBean leader-name from kafka.connect:type=connect-worker-rebalance-metrics
  - [display-metrics-api](playground%20connector%20display-metrics-api) - 〽️ Display metrics api for fully managed connector
  - [display-metrics-api-with-grafana](playground%20connector%20display-metrics-api-with-grafana) - 📊 Display metrics api for fully managed connector in Grafana dashboard
  - [enable-remote-debugging](playground%20connector%20enable-remote-debugging) - ✨ Enable java remote debugging for the connector.
  - [error-recommendations](playground%20connector%20error-recommendations) - 💡 Show error recommendations for fully managed connectors
  - [flow](playground%20connector%20flow) - 🗺️ Show the flow of the running connectors: source → topic → sinks, with the records, the lag and the DLQ
  - [history](playground%20connector%20history) - 🕰️ Show the history of a connector: state changes, failures, restarts and config changes
  - [log-level](playground%20connector%20log-level) - 🧬 Set connect log level
  - [logs](playground%20connector%20logs) - 🕵️  Tail and follow connect logs
  - [metrics](playground%20connector%20metrics) - 📈 Show the metrics of a connector: throughput, time, errors, and the metrics of the connector itself
  - [offsets](playground%20connector%20offsets) - 💈 Handle source and sink connectors offsets
    - [alter](playground%20connector%20offsets%20alter) - ⛏️ Alter offsets for source and sink connectors
    - [get](playground%20connector%20offsets%20get) - 🏹 Get current offsets for source and sink connectors
    - [get-offsets-request-status](playground%20connector%20offsets%20get-offsets-request-status) - 👁️‍🗨️ Get the status of the previous offset request
    - [reset](playground%20connector%20offsets%20reset) - 🆕 Reset offsets for source and sink connectors
  - [open-ccloud-connector-in-browser](playground%20connector%20open-ccloud-connector-in-browser) - 🤖 Open Fully Managed connector in browser (Confluent Cloud dashboard)
  - [open-docs](playground%20connector%20open-docs) - 🧑‍🎓 Open connector documentation of currently running connector(s)
  - [oracle-cdc-xstream](playground%20connector%20oracle-cdc-xstream) - 🅾️ Specific Oracle CDC Xstream commands
    - [debug](playground%20connector%20oracle-cdc-xstream%20debug) - 🐞 Execute various SQL commands to debug xstream components
    - [generate-report](playground%20connector%20oracle-cdc-xstream%20generate-report) - ⚙️ Generate and open oracle cdc xstream connector diagnostics
  - [pause](playground%20connector%20pause) - ⏸️  Pause connector
  - [plugins](playground%20connector%20plugins) - 🎨 Show all connector plugins installed. You can also display transforms, converters and predicates using `--all` flag
  - [reconcile](playground%20connector%20reconcile) - 🧮 Compare the records of the topic with the rows of the table: lost, duplicated, different?
  - [restart](playground%20connector%20restart) - ♻️  Restart connector
  - [resume](playground%20connector%20resume) - ⏯️  Resume connector
  - [select-config](playground%20connector%20select-config) - 🗜️ Easily select config from all possible configuration parameters of connector
  - [show-config](playground%20connector%20show-config) - 🧰 Show current connector config that was applied
  - [show-config-parameters](playground%20connector%20show-config-parameters) - 🔩 Show all possible configuration parameters of connector
  - [show-lag](playground%20connector%20show-lag) - 🐢 Show lag of sink connector
  - [smt](playground%20connector%20smt) - 🧪 Single message transforms (SMT)
    - [test](playground%20connector%20smt%20test) - 🧪 Apply the transform chain (SMT) of a connector to a record, step by step
  - [snippets](playground%20connector%20snippets) - 🔌 useful snippets
  - [sourcecode](playground%20connector%20sourcecode) - 🧑‍💻 open source code url for connector(s) used in example
  - [status](playground%20connector%20status) - 🧩 Show status of all connectors
  - [stop](playground%20connector%20stop) - 🛑 Stop connector (only available since CP 7.5)
  - [tasks](playground%20connector%20tasks) - 🧵 Show the tasks of a connector: state, worker, config and partitions
  - [topics](playground%20connector%20topics) - 📚 Show the topics a connector is using, or reset that list
  - [translate](playground%20connector%20translate) - 💱 Translate Self Managed Connector Plugin Configurations to Fully Managed Connector Plugin Configuration
  - [update](playground%20connector%20update) - 🛠️ Update connector configuration by opening current connector config in text editor set with playground config editor `<editor>` (default is code). Once file is saved, the new configuration is updated.
  - [validate](playground%20connector%20validate) - ✅ Validate a connector config without creating the connector
  - [versions](playground%20connector%20versions) - 🧞 Get current and latest versions available on Confluent Hub for connector(s) used in example
  - [wait](playground%20connector%20wait) - ⏳ Wait for connectors to reach a state

### Connector-Plugin commands

- [connector-plugin](playground%20connector-plugin) - 🔌 Connector-plugin commands
  - [changelog](playground%20connector-plugin%20changelog) - 📜 Show the release notes of a connector plugin between two versions
  - [config-diff](playground%20connector-plugin%20config-diff) - 🔧 Configuration keys added, removed or changed between two versions of a plugin
  - [config-key](playground%20connector-plugin%20config-key) - 🔑 Explain a connector configuration key: documentation, type, default, since when, and which examples set it
  - [cve-scan](playground%20connector-plugin%20cve-scan) - 🛡️ Known vulnerabilities (CVE) of the jars of a connector plugin version
  - [dependencies](playground%20connector-plugin%20dependencies) - 📚 Libraries bundled in a connector plugin, and what changed between two versions
  - [display-last-updated](playground%20connector-plugin%20display-last-updated) - 🆕 List last updated connector plugins from confluent hub https://www.confluent.io/hub/
  - [fm-versions](playground%20connector-plugin%20fm-versions) - ☁️ Fully managed connector: the connector version shipped by each cc-connect image (Confluent employees)
  - [info](playground%20connector-plugin%20info) - 🪪 One page on a connector plugin of Confluent Hub
  - [search-jar](playground%20connector-plugin%20search-jar) - ☕ List jars for a connector plugin from confluent hub https://www.confluent.io/hub/
  - [sourcecode](playground%20connector-plugin%20sourcecode) - 🧑‍💻 Open source code url in your browser (or in your editor when used with `--open`)
  - [versions](playground%20connector-plugin%20versions) - 💯 List versions for a connector plugin from confluent hub https://www.confluent.io/hub/

### Container commands

- [container](playground%20container) - 🐳 Container commands
  - [change-jdk](playground%20container%20change-jdk) - 🤎 Change java JDK version using Azul JDK (https://www.azul.com/downloads/#downloads-table-zulu)
  - [cp](playground%20container%20cp) - 🪄 Copy files between local filesystem and container
  - [display-error-all](playground%20container%20display-error-all) - 🔥 Display all ERROR/FATAL logs in all containers/pods. Useful for quick troubleshooting
  - [exec](playground%20container%20exec) - 🪄 Execute command in a container
  - [get-ip-addresses](playground%20container%20get-ip-addresses) - 🖥️  Get ip address of running containers
  - [get-properties](playground%20container%20get-properties) - 📝 Get properties file from a container
  - [kill](playground%20container%20kill) - 🔫 Kill a container
  - [kill-all](playground%20container%20kill-all) - 💀 Kill all containers and prune all volumes
  - [logs](playground%20container%20logs) - 🕵️  Tail and follow container logs
  - [pause](playground%20container%20pause) - ⏸️  Pause a container
  - [recreate](playground%20container%20recreate) - 💫 Recreate container(s)
  - [restart](playground%20container%20restart) - 🔁 Restart a container
  - [resume](playground%20container%20resume) - ⏯️  Resume a container
  - [set-environment-variables](playground%20container%20set-environment-variables) - 📦  Set environment variable(s) for a container
  - [ssh](playground%20container%20ssh) - 🛬 SSH into container
  - [update](playground%20container%20update) - ✍️ Edit and apply runtime container/pod definition
- [get-docker-compose](playground%20get-docker-compose) - 🐋 Get docker-compose

### Database commands

- [db](playground%20db) - 🛢️ Database commands
  - [cdc-check](playground%20db%20cdc-check) - 🔍 Check the CDC prerequisites of the database
  - [sql](playground%20db%20sql) - 🛢️ Run SQL statements with the client of the database
  - [wait-for-rows](playground%20db%20wait-for-rows) - ⏳ Wait for a table to contain a minimum number of rows

### Debug commands

- [debug](playground%20debug) - 🐞 Debug commands
  - [block-traffic](playground%20debug%20block-traffic) - 🚫 Blocking traffic using iptables
  - [cfk](playground%20debug%20cfk) - 🧱 CFK debug sub-commands
    - [generate-bundle](playground%20debug%20cfk%20generate-bundle) - ⛑️ Generate a Support bundle
    - [sourcecode](playground%20debug%20cfk%20sourcecode) - 🧑‍💻 Source code of the CFK operator at the version of a cluster or of a support bundle
  - [clock](playground%20debug%20clock) - ⏰ Shift the clock of a container: token, ticket and certificate expiry, time based partitioning
  - [degrade-traffic](playground%20debug%20degrade-traffic) - 🐌 Add latency, packet loss, corruption or a bandwidth limit using tc
  - [disable-remote-debugging](playground%20debug%20disable-remote-debugging) - 🛑 Disable java remote debugging for container
  - [dns](playground%20debug%20dns) - 🔤 Break the name resolution of a hostname inside a container: NXDOMAIN, a wrong ip, a slow resolver
  - [enable-remote-debugging](playground%20debug%20enable-remote-debugging) - ✨ Enable java remote debugging for container
  - [flight-recorder](playground%20debug%20flight-recorder) - 🛩️ Record a JVM with Java Flight Recorder, from `--action` start to `--action` stop
  - [generate-diagnostics](playground%20debug%20generate-diagnostics) - ⛑️ Generate a diagnostic bundle with Diagnostics Bundle Tool
  - [heap-dump](playground%20debug%20heap-dump) - 👻 Take a heap dump
  - [java-debug](playground%20debug%20java-debug) - 🤎 JVM arguments for SSL, Kerberos or Class Loading
  - [jscissors](playground%20debug%20jscissors) - ✂️ Trace the calls of any method of a running JVM: arguments, return values, durations, exceptions, call tree
  - [log-level](playground%20debug%20log-level) - 🧬 Set log level for any package
    - [get](playground%20debug%20log-level%20get) - Get log levels
    - [set](playground%20debug%20log-level%20set) - Set log level for specific logger
  - [resources](playground%20debug%20resources) - 🏋️ Limit the cpus and memory of a running container, or fill its disk: OOM, GC pressure, disk full
  - [tcp-dump](playground%20debug%20tcp-dump) - 🕵️‍♂️ Take a tcp dump (sniffing network)
  - [testssl](playground%20debug%20testssl) - 🔐 Testing TLS/SSL encryption using https://testssl.sh/
  - [thread-dump](playground%20debug%20thread-dump) - 🎯 Take a java thread dump

### EC2 commands

- [ec2](playground%20ec2) - ✨ Create and manage AWS EC2 instances (using Cloud Formation) to run kafka-docker-playground
  - [auto-stop](playground%20ec2%20auto-stop) - ⏰ Stop your EC2 instances left running, every evening, automatically
    - [disable](playground%20ec2%20auto-stop%20disable) - 🛑 Remove the auto-stop schedule
    - [enable](playground%20ec2%20auto-stop%20enable) - ⏰ Schedule the auto-stop, then show what tonight's run would stop
    - [run](playground%20ec2%20auto-stop%20run) - ⏰ Stop now your idle EC2 instances still running, as the scheduled job does
    - [status](playground%20ec2%20auto-stop%20status) - 🔎 Is the auto-stop scheduled, at what time, and what did its last runs do
  - [create](playground%20ec2%20create) - 👷 Create kafka-docker-playground EC2 instance using AWS Cloud Formation
  - [delete](playground%20ec2%20delete) - ❌ Delete an EC2 instance created with Cloud Formation
  - [list](playground%20ec2%20list) - 🔘 List all EC2 instance
  - [open](playground%20ec2%20open) - 👨‍💻 Open an EC2 instance using Visual Studio code
  - [push-secrets](playground%20ec2%20push-secrets) - 🔐 Send the secrets store to an ec2 instance
  - [start](playground%20ec2%20start) - 🟢 Start an EC2 instance
  - [stop](playground%20ec2%20stop) - 🔴 Stop an EC2 instance
  - [sync-repro-folder](playground%20ec2%20sync-repro-folder) - ↔️ Synchronize reproduction-models folder between local and ec2 instance
    - [ec2-to-local](playground%20ec2%20sync-repro-folder%20ec2-to-local) - 👈 Sync ec2 instance reproduction-models folder to local
    - [local-to-ec2](playground%20ec2%20sync-repro-folder%20local-to-ec2) - 👉 Sync local reproduction-models folder to ec2 instance

### Flink commands

- [flink](playground%20flink) - 🐿️ Flink commands
  - [cancel](playground%20flink%20cancel) - 🛑 Cancel a Flink job
  - [list-jobs](playground%20flink%20list-jobs) - 📋 List the jobs of the Flink cluster
  - [sql](playground%20flink%20sql) - 🐿️ Run Flink SQL statements with the SQL client
  - [table-ddl](playground%20flink%20table-ddl) - 🧱 Print the Flink SQL CREATE TABLE of a Kafka topic, its columns read from the Avro value schema in Schema Registry
  - [ui](playground%20flink%20ui) - 🌐 Open the Flink UI of the local Flink cluster in the browser

### Kafka commands

- [broker](playground%20broker) - 🖥️ Broker commands
  - [config](playground%20broker%20config) - ⚙️ Dynamic broker config commands
    - [delete](playground%20broker%20config%20delete) - 🗑️ Remove a dynamic broker config
    - [get](playground%20broker%20config%20get) - 🔎 Display dynamic broker configs
    - [set](playground%20broker%20config%20set) - ⚙️ Set a dynamic broker config
  - [describe](playground%20broker%20describe) - 🗺️ Describe the cluster
  - [health](playground%20broker%20health) - 🩺 Check the health of the cluster
  - [metrics](playground%20broker%20metrics) - 📈 Display the key JMX metrics of the brokers
  - [rolling-restart](playground%20broker%20rolling-restart) - 🔄 Restart the brokers one by one, like a rolling upgrade
  - [start](playground%20broker%20start) - ▶️ Start a broker stopped with `playground broker stop`
  - [stop](playground%20broker%20stop) - 🛑 Stop a broker
  - [transactions](playground%20broker%20transactions) - 💱 Transaction commands
    - [abort](playground%20broker%20transactions%20abort) - 🧹 Abort a hanging transaction
    - [describe](playground%20broker%20transactions%20describe) - 🔎 Describe a transactional id
    - [describe-producers](playground%20broker%20transactions%20describe-producers) - 🏭 Describe the active producers of a topic
    - [find-hanging](playground%20broker%20transactions%20find-hanging) - 🧟 Find hanging transactions
    - [list](playground%20broker%20transactions%20list) - 📋 List the transactional ids
- [get-jmx-metrics](playground%20get-jmx-metrics) - 🔢 Get JMX metrics from a container
- [quota](playground%20quota) - 🚦 Client quota commands
  - [delete](playground%20quota%20delete) - 🗑️ Remove client quotas
  - [get](playground%20quota%20get) - 🔎 Display client quotas
  - [set](playground%20quota%20set) - 🚦 Set client quotas

### Kafka Streams commands

- [streams](playground%20streams) - 🌊 Kafka Streams commands
  - [status](playground%20streams%20status) - 🌊 Show the state of the Kafka Streams instances

### ksqlDB commands

- [ksqldb](playground%20ksqldb) - 🧮 ksqlDB commands
  - [describe](playground%20ksqldb%20describe) - 🔎 Describe a stream or a table
  - [list](playground%20ksqldb%20list) - 📋 List the streams, tables and persistent queries
  - [metrics](playground%20ksqldb%20metrics) - 📈 Display the key JMX metrics of the ksqlDB server
  - [sql](playground%20ksqldb%20sql) - 🧮 Run ksqlDB statements with the ksql cli
  - [wait](playground%20ksqldb%20wait) - ⏳ Wait until the persistent queries are RUNNING and have no lag

### RBAC commands

- [rbac](playground%20rbac) - 🛡️ RBAC commands (rbac-sasl-plain, rbac-oauth and cfk-rbac environments, plus Confluent Cloud ACLs)
  - [acl](playground%20rbac%20acl) - 🚦 ACL commands
    - [create](playground%20rbac%20acl%20create) - 🚦 Create ACLs, one per `--operation`
    - [delete](playground%20rbac%20acl%20delete) - 🗑️ Delete ACLs, one per `--operation`
    - [list](playground%20rbac%20acl%20list) - 📋 List ACLs
  - [role-binding](playground%20rbac%20role-binding) - 🔐 Role binding commands
    - [create](playground%20rbac%20role-binding%20create) - 🔐 Create a role binding
    - [delete](playground%20rbac%20role-binding%20delete) - 🗑️ Delete a role binding
    - [list](playground%20rbac%20role-binding%20list) - 📋 List role bindings
  - [user](playground%20rbac%20user) - 🧑 LDAP user commands (Keycloak clients on rbac-oauth)
    - [add](playground%20rbac%20user%20add) - ➕ Add an LDAP user (a Keycloak client on rbac-oauth)
    - [delete](playground%20rbac%20user%20delete) - 🗑️ Delete an LDAP user, and remove it from its groups (the Keycloak client on rbac-oauth)
    - [list](playground%20rbac%20user%20list) - 📋 List LDAP users and their groups (Keycloak clients, secrets and groups on rbac-oauth)

### Repro commands

- [repro](playground%20repro) - 👷‍♂️ Reproduction model commands
  - [assert](playground%20repro%20assert) - 🧪 End a reproduction model with its verdict: 🐞 REPRODUCED or ✅ NOT REPRODUCED
  - [bisect](playground%20repro%20bisect) - 🔀 Run a reproduction model on several versions: which one introduced or fixed the problem
  - [bootstrap](playground%20repro%20bootstrap) - 🛠  Bootstrap reproduction model, just run `<playground repro bootstrap>` !
  - [check](playground%20repro%20check) - 🕵️ Scan reproduction models for secrets and customer data before they are committed
  - [diff](playground%20repro%20diff) - 🔀 Show what a reproduction model changes compared with its base example
  - [export](playground%20repro%20export) - 📤 Export reproduction models as a self-contained tgz bundle
  - [import](playground%20repro%20import) - 📥 Import a tgz bundle created by `playground repro export`
  - [list](playground%20repro%20list) - 📋 List the reproduction models, newest first, with their case, status and last verdict
  - [pipeline-builder](playground%20repro%20pipeline-builder) - 🔗 Open the pipeline builder: pick a source and sink examples, see the flow, copy the bootstrap command
  - [status](playground%20repro%20status) - 🩹 Show or update what a reproduction model proves, from its header

### Run commands

- [ccloud-changelog](playground%20ccloud-changelog) - 📰 Search the Confluent Cloud release notes by date, connector, category or text
- [cp-changelog](playground%20cp-changelog) - 📜 Show what changed in Confluent Platform between two versions
- [find-command](playground%20find-command) - 🧭 Find the playground command that answers a question, without reading the docs
- [find-example](playground%20find-example) - 🔎 Find examples matching a free-text query, without the interactive picker
- [get-ci-result](playground%20get-ci-result) - 🤖 get CI result for current example
- [history](playground%20history) - 🏰 Get an history of the examples which were run with run command and run it again
- [open](playground%20open) - 👐 When `--file` is not provided, simply open last example you ran with `<playground run>`
- [open-changelog](playground%20open-changelog) - 📜 Open playground changelog (https://kafka-docker-playground.io/#/changelog)
- [open-docs](playground%20open-docs) - 🧑‍🎓 Open Confluent documentation of currently running example
- [re-run](playground%20re-run) - ⚡ Simply re-run last example you ran with `<playground run>`
- [refresh-cp-docker-images](playground%20refresh-cp-docker-images) - 🔄 Refresh (pull from Docker) all Confluent Platform docker images related to a version installed locally
- [run](playground%20run) - 🕹️ Run any example !
- [stop](playground%20stop) - 🛑 Stop currently running example
- [switch-back](playground%20switch-back) - 💺  Switch back from previous environment before switch-ccloud was called.
- [switch-ccloud](playground%20switch-ccloud) - 🌩️  Switch to ccloud environment.
- [switch-docker](playground%20switch-docker) - 🐳 Switch the container engine back to Docker
- [switch-podman](playground%20switch-podman) - 🦭 Switch the container engine to Podman
- [update-version](playground%20update-version) - ✨ Update current confluent platform components (all with `--tag` or only connect with `--connect-tag`) or connector(s) with new version(s)

### Schema commands

- [schema](playground%20schema) - 🔰 Schema commands
  - [check-compatibility](playground%20schema%20check-compatibility) - 🧪 Check whether a schema would be accepted, without registering it
  - [compare](playground%20schema%20compare) - 🔀 Compare the subjects of two registries (or two contexts)
  - [contexts](playground%20schema%20contexts) - 🗂️ List the contexts of the registry, with their number of subjects and mode
  - [delete](playground%20schema%20delete) - 🧟 Delete schema
  - [derive-schema](playground%20schema%20derive-schema) - 🪄 Derive a schema based on payload
  - [describe](playground%20schema%20describe) - 🔎 Everything about one subject, or one schema id, in one call
  - [diff](playground%20schema%20diff) - 🔀 Compare two schemas field by field, with the verdict of each compatibility rule
  - [export](playground%20schema%20export) - 📦 Export the subjects of the registry to a folder
  - [exporter](playground%20schema%20exporter) - 🔗 Schema Linking: exporters that copy subjects to another registry
    - [create](playground%20schema%20exporter%20create) - 🔗 Create an exporter, then wait until it runs
    - [delete](playground%20schema%20exporter%20delete) - 🗑️ Delete a paused exporter (the exported schemas stay in the destination)
    - [list](playground%20schema%20exporter%20list) - 📋 List the exporters of the registry, with their state
    - [pause](playground%20schema%20exporter%20pause) - ⏸️ Pause an exporter
    - [reset](playground%20schema%20exporter%20reset) - ⏮️ Reset a paused exporter: it exports everything again
    - [resume](playground%20schema%20exporter%20resume) - ▶️ Resume a paused exporter
    - [status](playground%20schema%20exporter%20status) - 🚦 State of an exporter (RUNNING, PAUSED, ERROR with its trace), offset and number of objects exported
  - [get](playground%20schema%20get) - 🔰 Get all schemas versions for specified subject (if `--subject` is not specified, all subjects will be used)
  - [get-alias](playground%20schema%20get-alias) - 🔯 Get subject alias
  - [get-compatibility](playground%20schema%20get-compatibility) - 🛡️ Get the compatibility rule in force
  - [get-mode](playground%20schema%20get-mode) - 🔏 Get the mode in force
  - [history](playground%20schema%20history) - 📜 Timeline of the Schema Registry, from its _schemas topic
  - [import](playground%20schema%20import) - 📥 Import schemas into the registry, keeping their ids
  - [list](playground%20schema%20list) - 📋 List the subjects of the registry
  - [metrics](playground%20schema%20metrics) - 📈 Display the key JMX metrics of Schema Registry
  - [register](playground%20schema%20register) - ⏺️ Register a schema in specified subject
  - [set-alias](playground%20schema%20set-alias) - 🔯 Set a subject alias
  - [set-compatibility](playground%20schema%20set-compatibility) - 🛡️ Set the compatibility rule of a subject (`--subject`), or of the whole registry (`--global`)
  - [set-mode](playground%20schema%20set-mode) - 🔏 Set the mode of a subject (`--subject`), or of the whole registry (`--global`)
  - [set-normalize](playground%20schema%20set-normalize) - 🧽 Set normalize at schema registry level
  - [test-rules](playground%20schema%20test-rules) - 📏 Test the data contract rules of a subject against records
  - [validate](playground%20schema%20validate) - 🧪 Register schemas in a throwaway Schema Registry of each CP version, and compare the verdicts
  - [validate-new-schemas](playground%20schema%20validate-new-schemas) - 🩺 Validate new schemas (default is true since CP 8.2.0)

### Secrets commands

- [secrets](playground%20secrets) - 🔐 Credentials required by examples
  - [backend](playground%20secrets%20backend) - 🏦 Show or change where secrets are kept
  - [check](playground%20secrets%20check) - ✅ Show what an example needs, and what is missing
  - [edit](playground%20secrets%20edit) - ✏️ Open the store in your editor
  - [env](playground%20secrets%20env) - 🐚 Export what an example needs into the current shell
  - [export](playground%20secrets%20export) - 📤 Write every credential of a profile to a file, in clear text
  - [get](playground%20secrets%20get) - 🔍 Show a stored credential (masked unless `--reveal` is used)
  - [import](playground%20secrets%20import) - 📥 Import an existing secret.properties / variable.properties file
  - [link](playground%20secrets%20link) - 🔗 Point a variable at a secret manager, without storing any value
  - [list](playground%20secrets%20list) - 📋 List stored credentials
  - [profile](playground%20secrets%20profile) - 🗂️ Show or switch the active profile
  - [scan](playground%20secrets%20scan) - 🔎 Look for stored credentials in clear text in the repository
  - [set](playground%20secrets%20set) - 🔐 Store a credential
  - [unset](playground%20secrets%20unset) - 🗑️ Remove a stored credential

### TCP Proxy commands

- [tcp-proxy](playground%20tcp-proxy) - 🏚 Zazkia TCP Proxy commands
  - [break](playground%20tcp-proxy%20break) - 💔 Break sending the response to the client.
  - [close-all-connection-with-error](playground%20tcp-proxy%20close-all-connection-with-error) - 🧹 Close all Zazkia TCP connections which are in error state
  - [close-connection](playground%20tcp-proxy%20close-connection) - ❌ Close the Zazkia active TCP connections
  - [delay](playground%20tcp-proxy%20delay) - ⏲️ Add milliseconds delay to service response.
  - [get-connections](playground%20tcp-proxy%20get-connections) - 🧲 Get Zazkia active TCP connections config and stats
  - [open-ui](playground%20tcp-proxy%20open-ui) - 🌐 Just open Zazkia UI (http://localhost:9191) in your browser
  - [start](playground%20tcp-proxy%20start) - 💗 Start the TCP proxy and automatically replace connector config with zazkia hostname and port 49998
  - [toggle-accept-connections](playground%20tcp-proxy%20toggle-accept-connections) - 🙅‍♂️ Change whether new connections can be accepted
  - [toggle-reads-client](playground%20tcp-proxy%20toggle-reads-client) - ✅ Change whether reading data from the client is enabled.
  - [toggle-reads-service](playground%20tcp-proxy%20toggle-reads-service) - ✅ Change whether reading data from the service is enabled.
  - [toggle-writes-client](playground%20tcp-proxy%20toggle-writes-client) - ✅ Change whether writing data to the client is enabled.
  - [toggle-writes-service](playground%20tcp-proxy%20toggle-writes-service) - ✅ Change whether writing data to the service is enabled.

### Tools commands

- [tools](playground%20tools) - 🧰 Tools commands
  - [cert](playground%20tools%20cert) - 🔐 Certificate commands
    - [convert](playground%20tools%20cert%20convert) - 🔄 Convert certificates and keystores between formats
    - [create](playground%20tools%20cert%20create) - 🔐 Generate keys and certificates used for SSL
    - [inspect](playground%20tools%20cert%20inspect) - 🔍 Inspect certificates and explain what breaks TLS
  - [http-server](playground%20tools%20http-server) - 🌐 Drive the http test server of the http examples
    - [requests](playground%20tools%20http-server%20requests) - 📥 Show the requests received by the http test server
    - [reset](playground%20tools%20http-server%20reset) - 🔄 Reset the http test server
    - [set-response](playground%20tools%20http-server%20set-response) - 🎛️ Set how the http test server answers
  - [install-alfred-workflow](playground%20tools%20install-alfred-workflow) - 🎩 Install the "kafka-docker-playground (kdp)" Alfred workflow (macOS, Alfred 5 with the Powerpack)
  - [install-vscode-extension](playground%20tools%20install-vscode-extension) - 🪄 Install a slightly modified version of "Shell Script Command Completion" Visual Studio Code extension (https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)
  - [read-avro-file](playground%20tools%20read-avro-file) - 🔖 Read provided avro file
  - [read-parquet-file](playground%20tools%20read-parquet-file) - 🔖 Read provided parquet file
  - [redos-check](playground%20tools%20redos-check) - 🪖 Check topics.regex for ReDos vulnerabilities using recheck (https://github.com/makenowjust-labs/recheck)

### Topic commands

- [consumer-group](playground%20consumer-group) - 👥 Consumer group commands
  - [delete](playground%20consumer-group%20delete) - 🗑️ Delete a consumer group, or its offsets for one topic
  - [describe](playground%20consumer-group%20describe) - 🔬 Describe consumer group
  - [list](playground%20consumer-group%20list) - 👥 List consumer groups
  - [reset-offsets](playground%20consumer-group%20reset-offsets) - ⏪ Reset the committed offsets of a consumer group
- [topic](playground%20topic) - 🗳 Topic commands
  - [alter](playground%20topic%20alter) - 🪛 Alter topic config
  - [check-format](playground%20topic%20check-format) - 🧬 Check the format of the records of a topic, from their bytes
  - [compare](playground%20topic%20compare) - 🔀 Compare a topic with its replica: is everything replicated?
  - [consume](playground%20topic%20consume) - 📥 Consume topic from beginning
  - [create](playground%20topic%20create) - 🆕 Create topic
  - [delete](playground%20topic%20delete) - ❌ Delete topic and associated schema/subject if applicable
  - [describe](playground%20topic%20describe) - 🔬 Describe topic
  - [display-consumer-offsets](playground%20topic%20display-consumer-offsets) - 📭 Display content of __consumer_offsets topic
  - [dlq](playground%20topic%20dlq) - 📬 Dead letter queue commands
    - [inspect](playground%20topic%20dlq%20inspect) - 🩺 Show what is in a dead letter queue, grouped by error
    - [replay](playground%20topic%20dlq%20replay) - 🔁 Produce the records of a dead letter queue again
  - [dump-log](playground%20topic%20dump-log) - 🔬 Dump the log segments of a partition: batches, producers, transactions
  - [elect-leader](playground%20topic%20elect-leader) - 👑 Elect the leaders of a topic
  - [get-number-records](playground%20topic%20get-number-records) - 💯 Get number of records in a topic
  - [get-offsets](playground%20topic%20get-offsets) - 📍 Get earliest and latest offsets per partition of a topic
  - [get-size](playground%20topic%20get-size) - 📏 Get size of topics
  - [list](playground%20topic%20list) - 🔘 List topics
  - [produce](playground%20topic%20produce) - 📤 Produce to a topic
  - [reassign](playground%20topic%20reassign) - 🔀 Move the replicas of a topic to other brokers
  - [set-schema-compatibility](playground%20topic%20set-schema-compatibility) - 🛡️ Change topic's schema compatibility
  - [tag](playground%20topic%20tag) - 🏷️ Stream Catalog tags (Confluent Cloud only)
    - [add](playground%20topic%20tag%20add) - 🏷️ Assign a tag to a topic
    - [create](playground%20topic%20tag%20create) - 🆕 Create a tag definition
    - [delete](playground%20topic%20tag%20delete) - ❌ Delete a tag definition
    - [list](playground%20topic%20tag%20list) - 🏷️ List tag definitions
    - [remove](playground%20topic%20tag%20remove) - 🧽 Remove a tag from a topic
    - [search](playground%20topic%20tag%20search) - 🔎 Search topics having a tag
    - [show](playground%20topic%20tag%20show) - 🔎 Show tags assigned to a topic
  - [wait-for-records](playground%20topic%20wait-for-records) - ⏳ Wait for a topic to contain a minimum number of records

## Options

#### `--vvv, -v`

🐛 set verbose output (set -x)

❗ it can print sensitive information ❗

#### `--output-level, -o LEVEL`

❕Log level used by all commands

Default is INFO (all INFO, WARN and ERROR will be printed in command output)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `INFO`, `WARN`, `ERROR`


