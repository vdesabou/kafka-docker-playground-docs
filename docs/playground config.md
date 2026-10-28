# playground config

⚙️ Configure CLI

Your preferences, kept between sessions:

- **editor `<name>`**: the editor every command opens files with (code, vi, nano...)
- **folder_zip_or_jar `<dir>`...**: where to look for connector zips and jars, in addition to the current folder
- **clipboard true|false**: copy connector config to the clipboard (macOS only)
- **container-kill-all-before-run**: kill every container before each run, or just stop the example
- **cleanup-ccloud-resources-after-run delete the Confluent Cloud connectors**: and topics of the last ccloud run on stop and before the next run (ask, true or false)
- **check-and-update-repo-version**: warn when your clone is out of date
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

- [editor](playground%20config%20editor) - editor to use to open files
- [folder_zip_or_jar](playground%20config%20folder_zip_or_jar) - 📂 list of folders where to search for zip or jar
- [clipboard](playground%20config%20clipboard) - copy to clipboard connector config (only working on MacOS)
- [open-ccloud-connector-in-browser](playground%20config%20open-ccloud-connector-in-browser) - when running a fully managed connector example, it opens the connector in browser
- [open-grafana-in-browser](playground%20config%20open-grafana-in-browser) - when running an example with `--enable-jmx-grafana` flag, it opens grafana in browser
- [container-kill-all-before-run](playground%20config%20container-kill-all-before-run) - when running an example, always call playground container kill-all first. If set to false, it will call playground stop instead.
- [run-log](playground%20config%20run-log) - 📄 write a masked log of each `playground run` (default true)
- [run-log-folder](playground%20config%20run-log-folder) - 🗂️ folder of the run logs
- [open-diagnose-report-on-failure](playground%20config%20open-diagnose-report-on-failure) - 🩺 open the HTML report when a connector fails (default true)
- [display-last-updated-connector-plugins](playground%20config%20display-last-updated-connector-plugins) - 🆕 at the end of a self-managed connector run, list the connector plugins released recently on Confluent Hub (default false)
- [display-last-updated-connector-plugins-days](playground%20config%20display-last-updated-connector-plugins-days) - 📅 number of days to look back for display-last-updated-connector-plugins
- [display-last-updated-connector-plugins-vendor](playground%20config%20display-last-updated-connector-plugins-vendor) - 🏢 vendor of the connector plugins listed by display-last-updated-connector-plugins
- [cleanup-ccloud-resources-after-run](playground%20config%20cleanup-ccloud-resources-after-run) - 🧹 delete the Confluent Cloud resources left by the last ccloud example
- [check-and-update-repo-version](playground%20config%20check-and-update-repo-version) - when running an example, always check if repo version is older than 3 days, if disabled, it will skip this check.


