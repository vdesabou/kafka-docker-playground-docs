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

#### *--compile*

🏗️ Checkout and compile code, then restart the connector with new compiled code 💫  
  
You must have git installed.  
  
Confluent employees only: make sure to follow "Maven FAQ"  
  
This does not work for fully and custom connectors.

#### *--compile-verbose, -v*

🐞 Show output of compilation.

#### *--compile-jdk-version COMPILE_JDK_VERSION*

🤎 JDK version to use when compiling  
It will check in pom.xml for maven-compiler-plugin source/target version or release version and set jdk accordingly  
Default is 11

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | 8, 11, 17, 20

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


