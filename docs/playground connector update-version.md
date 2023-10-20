# playground connector update-version

✨ Update currently running connector(s) with new version 

## Usage

```bash
playground connector update-version [OPTIONS]
```

## Options

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the latest available version on Confluent Hub is used

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--connector-zip*

#### *--connector-zip CONNECTOR_ZIP*

🤐 Connector zip to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use folder_zip_or_jar (default: ~/Downloads) in config.ini file to configure where to search the files (current folder is always used)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--connector-tag*

#### *--connector-jar CONNECTOR_JAR*

♨️ Connector jar to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use folder_zip_or_jar (default: ~/Downloads) in config.ini file to configure where to search the files (current folder is always used)


