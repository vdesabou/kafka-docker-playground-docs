# playground connector-plugin sourcecode

🧑‍💻 Open source code url in your browser (or in your editor when used with `--open`)

You can compare different sourcecode versions by specifying `--connector-tag` two times, in such case it will open github in comparison mode

🏗️ Compile code and generate zip file(s) by providing `--compile` flag

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-plugin  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%A7%91%F0%9F%92%BB-the-source-code-of-a-connector-at-the-customers-version

## Usage

```bash
playground connector-plugin sourcecode [OPTIONS]
```

## Environment Variables

#### `GH_TOKEN`

🔑 GitHub token, needed for fully managed connectors (cc-docker-connect is private)

#### `GITHUB_TOKEN`

🔑 GitHub token, used when `GH_TOKEN` is not set

## Options

#### `--connector-plugin, -c CONNECTOR-PLUGIN`

🔌 Connector plugin name

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--only-show-url`

🌐 Only show url

#### `--connector-tag CONNECTOR_TAG`

🔗 Connector version to use

By default, for each connector, the latest available version on Confluent Hub is used (for Confluent employees, it will also get latest versions for fully managed connectors)

💌 Confluent employees only: for fully managed connectors, use the cc-connect image version for the pcc. You must have a Confluent Github token set with `GITHUB_TOKEN` or `GH_TOKEN` environment variable and also be using Confluent VPN.

🎓 Tip: set to " " in order to select the version dynamically (for Confluent plugins, the preview shows the release notes of each version)

🎓 Tip: you can compare different sourcecode versions by specifying `--connector-tag` two times, in such case it will open github in comparison mode

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--compile`

🏗️ Checkout and compile code

You must have git installed.

💌 Confluent employees only: make sure to follow "Maven FAQ", you also need to be on Confluent VPN with proper AWS credentials set in order to be able to download proprietary dependencies.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--checkout-only`

#### `--compile-jdk-version COMPILE_JDK_VERSION`

🤎 JDK version to use when compiling  
It will check in pom.xml for maven-compiler-plugin source/target version or release version and set jdk accordingly  
Default is 11

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `8`, `11`, `17`, `21`, `25`

#### `--compile-verbose, -v`

🐞 Show output of compilation.

#### `--open, -o`

🔖 Checkout the code and open with text editor set with playground config editor `<editor>` (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--checkout-only`

#### `--checkout-only`

📂 Checkout the code at the right tag and print the path of the folder, nothing else

No browser, no editor, no question: an existing checkout of the same  
version in /tmp/connector-plugin-sourcecode is reused. The path is  
the last line of the output.

🎓 Tip: use it in scripts and from AI agents, which can then read the code

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--open`, `--compile`

#### `--log`

📜 With 2 `--connector-tag`: the commits between the two versions, newest first

From the GitHub compare API (gh when logged in, else `GH_TOKEN` / `GITHUB_TOKEN` if set, else anonymous with  
a low rate limit). Merge commits are left out. Complements playground connector-plugin changelog, which is  
only as complete as the docs, and works for partner and fully managed plugins too.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--compile`, `--open`, `--checkout-only`

#### `--files`

🗂️ With 2 `--connector-tag`: the files changed between the two versions, with +/- line counts

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--compile`, `--open`, `--checkout-only`

#### `--path PATH`

📄 Only the changed files matching this glob, and their diff

Example: `--path` "\*/JdbcSinkConfig.java"

#### `--grep GREP`

🔎 One `--connector-tag`: grep the code at that version (checkout, file:line, 500 lines at most)

With 2 `--connector-tag` and `--log`: only the commits whose message matches (case insensitive).  
Extended regular expression, for example "`BATCH_SIZE_DEFAULT`|batch.size"

#### `--json`

🤖 Print the result as JSON (url, checkout folder, commits, files, matches), logs on stderr

## Examples

```bash

# commits between two versions, only the ones about offsets
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --connector-tag 10.9.9 --log --grep "offset"
# files changed between two versions, and the diff of one of them
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --connector-tag 10.9.9 --files --path "*/JdbcSinkConfig.java"
# grep the code of a version
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-jdbc --connector-tag 10.8.4 --grep "BATCH_SIZE_DEFAULT"
# will checkout the latest version from hub and print the path of the folder
playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-hdfs --checkout-only

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

## Example output

```text
$ playground connector-plugin sourcecode --connector-plugin confluentinc/kafka-connect-s3 --only-show-url
17:22:31 ℹ️ ✨ --connector-tag was not set, using latest version on hub 12.1.13
17:22:31 ℹ️ 🧑‍💻🌐 sourcecode for plugin confluentinc/kafka-connect-s3 for 12.1.13 version is available at:
https://github.com/confluentinc/kafka-connect-storage-cloud/tree/v12.1.13
```


