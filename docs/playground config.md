# playground config

⚙️ Configure CLI

Your preferences, kept between sessions:

- **editor `<name>`**: the editor every command opens files with (code, vi, nano...)
- **folder_zip_or_jar `<dir>`...**: where to look for connector zips and jars, in addition to the current folder
- **clipboard true|false**: copy connector config to the clipboard (macOS only)
- **container-kill-all-before-run**: kill every container before each run, or just stop the example
- **cleanup-ccloud-resources-after-run delete the Confluent Cloud connectors**: and topics of the last ccloud run on stop and before the next run (ask, true or false)
- **check-and-update-repo-version**: warn when your clone is out of date
- **account-check-before-run**: playground account `<provider>` check before the run (true by default)
- **run-log true|false**: write a masked log of each `playground run` to share it
- **run-log-folder `<dir>`**: where to write the run logs
- **open-diagnose-report-on-failure**: open the HTML report of the 'connector diagnose' run when a connector fails (true or false)
- **display-last-updated-connector-plugins**: list the connector plugins released recently at the end of a self-managed run (true or false, -days `<n>`, -vendor \<vendor|all\>)
- **open-ccloud-connector-in-browser**: open fully managed connectors, and in
- **open-grafana-in-browser**: which browser

🎓 Tip: all of them can also be changed from the '⚙️ CLI preferences'  
entry of the `playground run` menu.

## Usage

```bash
playground config COMMAND
```

## Commands

- [account-check-before-run](playground%20config%20account-check-before-run) - 🩺 When running an example of a provider (gcp, azure, aws, snowflake, salesforce, servicenow, databricks, zendesk, jira, marketo, clickhouse, couchbase, mongodb-atlas, pagerduty), call playground account `<provider>` check first: a login that does not work stops the run in a few seconds instead of failing minutes later. True by default, never done in CI.
- [check-and-update-repo-version](playground%20config%20check-and-update-repo-version) - 🔄 Warn when your clone of the repository is more than 3 days old, before running an example
- [cleanup-ccloud-resources-after-run](playground%20config%20cleanup-ccloud-resources-after-run) - 🧹 delete the Confluent Cloud resources left by the last ccloud example
- [clipboard](playground%20config%20clipboard) - 📋 Copy the connector config to the clipboard (macOS only)
- [container-kill-all-before-run](playground%20config%20container-kill-all-before-run) - 💀 Kill every container before each run (playground container kill-all). If set to false, only stop the previous example (playground stop).
- [display-last-updated-connector-plugins](playground%20config%20display-last-updated-connector-plugins) - 🆕 at the end of a self-managed connector run, list the connector plugins released recently on Confluent Hub (default false)
- [display-last-updated-connector-plugins-days](playground%20config%20display-last-updated-connector-plugins-days) - 📅 number of days to look back for display-last-updated-connector-plugins
- [display-last-updated-connector-plugins-vendor](playground%20config%20display-last-updated-connector-plugins-vendor) - 🏢 vendor of the connector plugins listed by display-last-updated-connector-plugins
- [editor](playground%20config%20editor) - 📝 Editor that every command opens files with
- [folder_zip_or_jar](playground%20config%20folder_zip_or_jar) - 📂 list of folders where to search for zip or jar
- [open-ccloud-connector-in-browser](playground%20config%20open-ccloud-connector-in-browser) - 🌐 Open the connector in the browser when running a fully managed connector example
  - [automatically](playground%20config%20open-ccloud-connector-in-browser%20automatically) - 🌐 Open the connector in the browser automatically
  - [browser](playground%20config%20open-ccloud-connector-in-browser%20browser) - 🧭 Browser to use
- [open-diagnose-report-on-failure](playground%20config%20open-diagnose-report-on-failure) - 🩺 open the HTML report when a connector fails (default true)
- [open-grafana-in-browser](playground%20config%20open-grafana-in-browser) - 📊 Open Grafana in the browser when running an example with `--enable-jmx-grafana`
  - [automatically](playground%20config%20open-grafana-in-browser%20automatically) - 📊 Open Grafana in the browser automatically
  - [browser](playground%20config%20open-grafana-in-browser%20browser) - 🧭 Browser to use
- [run-log](playground%20config%20run-log) - 📄 write a masked log of each `playground run` (default true)
- [run-log-folder](playground%20config%20run-log-folder) - 🗂️ folder of the run logs


