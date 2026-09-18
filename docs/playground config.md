# playground config

⚙️ Configure CLI  
  
Your preferences, kept between sessions:  
  
  editor \<name\>                      the editor every command opens files  
                                     with (code, vi, nano...)  
  folder_zip_or_jar \<dir\>...         where to look for connector zips and  
                                     jars, in addition to the current  
                                     folder  
  clipboard true|false               copy connector config to the  
                                     clipboard (macOS only)  
  container-kill-all-before-run      kill every container before each run,  
                                     or just stop the example  
  check-and-update-repo-version      warn when your clone is out of date  
  open-ccloud-connector-in-browser   open fully managed connectors, and in  
  open-grafana-in-browser            which browser

## Usage

```bash
playground config COMMAND
```

## == Commands ==

- [editor](playground%20config%20editor) - editor to use to open files
- [folder_zip_or_jar](playground%20config%20folder_zip_or_jar) - 📂 list of folders where to search for zip or jar
- [clipboard](playground%20config%20clipboard) - copy to clipboard connector config (only working on MacOS)
- [open-ccloud-connector-in-browser](playground%20config%20open-ccloud-connector-in-browser) - when running a fully managed connector example, it opens the connector in browser
- [open-grafana-in-browser](playground%20config%20open-grafana-in-browser) - when running an example with --enable-jmx-grafana flag, it opens grafana in browser
- [container-kill-all-before-run](playground%20config%20container-kill-all-before-run) - when running an example, always call playground container kill-all first. If set to false, it will call playground stop instead.
- [check-and-update-repo-version](playground%20config%20check-and-update-repo-version) - when running an example, always check if repo version is older than 3 days, if disabled, it will skip this check.


