# playground connector-plugin sourcecode

🧑‍💻 Open source code url in your browser (or in your editor when used with --open)  
  
You can compare different sourcecode versions by specifying --connector-tag two times, in such case it will open github in comparison mode  
  
🏗️ Compile code and generate zip file(s) by providing --compile flag  


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
  
💌 Confluent employees only: for fully managed connectors, use the cc-connect image version for the pcc. You must have a Confluent Github token set with GITHUB_TOKEN or GH_TOKEN environment variable and also be using Confluent VPN.  
  
🎓 Tip: set to " " in order to select the version dynamically  
  
🎓 Tip: you can compare different sourcecode versions by specifying --connector-tag two times, in such case it will open github in comparison mode

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### *--compile*

🏗️ Checkout and compile code  
  
You must have git installed.  
  
💌 Confluent employees only: make sure to follow "Maven FAQ", you also need to be on Confluent VPN with proper AWS credentials set in order to be able to download proprietary dependencies.

#### *--compile-jdk-version COMPILE_JDK_VERSION*

🤎 JDK version to use when compiling  
It will check in pom.xml for maven-compiler-plugin source/target version or release version and set jdk accordingly  
Default is 11

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | 8, 11, 17, 21, 25

#### *--compile-verbose, -v*

🐞 Show output of compilation.

#### *--open, -o*

🔖 Checkout the code and open with text editor set with playground config editor \<editor\> (default is code)

## Examples

```bash

# will open latest version from hub source code
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs

# will ask you to select a version
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --connector-tag " "

# if you're a confluent employee (make sure to set your aws credentials), it will also work on proprietary connectors and fully managed connectors
playground connector-plugin sourcecode --connector-plugin confluentinc/MqttSource

# comparison mode:
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --connector-tag "10.2.1" --connector-tag "10.2.0"

# comparison mode (with versions selection):
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --connector-tag " " --connector-tag " "

# compile 
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-jdbc --compile

# if you're a confluent employee (make sure to set your aws credentials and follow Maven FAQ), it will also work on proprietary connectors and fully managed connectors 
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-oracle-xstream-cdc-source --compile --connector-tag "1.2.0" --compile-verbose

# will open repository in your editor
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --open

```


