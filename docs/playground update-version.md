# playground update-version

✨ Update current confluent platform components (all with --tag or only connect with --connect-tag) or connector(s) with new version(s)  
  
Re-runs the example you are currently on with different versions, which is  
the fastest way to answer "does it still happen on 8.x?" or "is it fixed in  
connector 10.6.0?".  
  
  --tag            🔢 every Confluent Platform component  
  --connect-tag    🔗 only the connect container, other components untouched  
  --connector-tag  🧩 the connector, from Confluent Hub  
  --connector-zip  📦 the connector, from a local zip or a URL  
  --connector-jar  ☕ a single jar, dropped into the existing plugin  
  
With no flag, you are prompted with the versions available. The versions  
currently running are read from the broker and connect containers, so the  
example must be up.  
  
🎓 Tip: this is a version bisect tool. Keep the example running and call it  
repeatedly until you find the version where the behaviour changes.

## Usage

```bash
playground update-version [OPTIONS]
```

## Options

#### *--tag TAG*

🎯 Confluent Platform (CP) version to use. Applies to all components (broker, connect, schema registry, ksqlDB, etc...)  
  
It sets TAG environment variable  
  
Must be greater or equal to 5.3.0  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--connect-tag CONNECT_TAG*

🔗 Confluent Platform (CP) version to use. Applies to connect only.  
  
It sets CP_CONNECT_TAG environment variable  
  
Must be greater or equal to 5.3.0  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the latest available version on Confluent Hub is used  
  
🎓 Tip: set to " " in order to select the version dynamically

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--connector-zip*

#### *--connector-zip CONNECTOR_ZIP*

🤐 Connector zip to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use playground config folder_zip_or_jar \<folder1\> \<folder2\>... (default is home folder and current folder is always included) to configure where to search the files  
        use \<option+enter\> to use the value you typed manually

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--connector-tag*

#### *--connector-jar CONNECTOR_JAR*

🤎 Connector jar to use  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion   
        use playground config folder_zip_or_jar \<folder1\> \<folder2\>... (default is home folder and current folder is always included) to configure where to search the files  
        use \<option+enter\> to use the value you typed manually

## Examples

```bash
playground update-version (interactive mode)
```

```bash
playground update-version --tag 6.2.0 --connector-tag=2.5.12,10.5.7
```

```bash
playground update-version --connect-tag 6.2.0 --connector-tag=2.5.12,10.5.7
```


