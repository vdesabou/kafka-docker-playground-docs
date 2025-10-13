# playground connector sourcecode

🧑‍💻 open source code url for connector(s) used in example  
  
You can compare different sourcecode versions by specifying --connector-tag two times, in such case it will open github in comparison mode  


## Usage

```bash
playground connector sourcecode [OPTIONS]
```

## Options

#### *--only-show-url*

🌐 Only show url

#### *--connector-tag CONNECTOR_TAG*

🔗 Connector version to use  
  
By default, for each connector, the current version is used (for Confluent employees, it will also get latest versions for fully managed connectors)  
  
🎓 Tip: set to " " in order to select the version dynamically  
  
🎓 Tip: you can compare different sourcecode versions by specifying --connector-tag two times, in such case it will open github in comparison mode

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

## Examples

```bash

# will open current version source code
# if you're a confluent employee (make sure to set your aws credentials), it will also work on proprietary connectors and fully managed connectors
playground connector sourcecode

# will ask you to select a version
playground connector sourcecode  --connector-tag " "

# comparison mode:
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --connector-tag "10.2.1" --connector-tag "10.2.0"

# comparison mode (with versions selection):
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --connector-tag " " --connector-tag " "

```


