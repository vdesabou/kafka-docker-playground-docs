# playground connector-plugin sourcecode

🧑‍💻 Open source code url in your browser  
  
You can compare different sourcecode versions by specifying --connector-tag two times, in such case it will open github in comparison mode  


## Usage

```bash
playground connector-plugin sourcecode [OPTIONS]
```

## Options

#### *--connector-plugin, -c CONNECTOR-PLUGIN*

🔌 Connector plugin name  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--only-show-url*

🌐 Only show url

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the latest available version on Confluent Hub is used (for Confluent employees, it will also get latest versions for fully managed connectors)  
  
🔢 Confluent employees only: for fully managed connectors, use the cc-connect image version for the pcc. You must have a Confluent Github token set with GITHUB_TOKEN or GH_TOKEN environment variable.  
  
🎓 Tip: set to " " in order to select the version dynamically  
  
🎓 Tip: you can compare different sourcecode versions by specifying --connector-tag two times, in such case it will open github in comparison mode

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

## Examples

```bash

# will open latest version from hub source code
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs

# will ask you to select a version
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --connector-tag " "

# if you're a confluent employee (make sure to set your aws credentials), it will also work on proprietary connectors and fully managed connectors
playground connector-plugin sourcecode --connector-plugin confluentinc/MqttSource

# comparison mode:
playground connector sourcecode --connector-tag "10.2.1" --connector-tag "10.2.0"

# comparison mode (with versions selection):
playground connector sourcecode --connector-tag " " --connector-tag " "

```


