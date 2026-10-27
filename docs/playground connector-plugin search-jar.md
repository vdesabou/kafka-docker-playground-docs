# playground connector-plugin search-jar

☕ List jars for a connector plugin from confluent hub https://www.confluent.io/hub/

Downloads the plugin and lists the jars it ships. With `--class` it also  
finds which jar contains that class and prints its method signatures  
with javap.

That answers the two questions a NoClassDefFoundError or a  
NoSuchMethodError raises: is the class actually shipped, and does the  
bundled version have the signature the code is calling. Run it again  
with another `--connector-tag` to see when a dependency changed.

## Usage

```bash
playground connector-plugin search-jar [OPTIONS]
```

## Dependencies

#### *javap*

visit https://openjdk.org/install/ to install

## Options

#### `--connector-plugin, -c CONNECTOR-PLUGIN`

🔌 Connector plugin name

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--connector-tag CONNECTOR_TAG`

🔗 Connector version to use

By default, for each connector, the latest available version on Confluent Hub is used

🎓 Tip: set to " " in order to select the version dynamically (for Confluent plugins, the preview shows the release notes of each version)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--connector-zip`

#### `--class CLASS`

☕ Java class name to search for in all jars

## Examples

```bash
playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-s3 --class WebIdentityTokenCredentialsProvider

```

## Example output

```text
$ playground connector-plugin search-jar --connector-plugin confluentinc/kafka-connect-s3 --class WebIdentityTokenCredentialsProvider
17:23:33 ℹ️ 🔌 Downloading connector plugin confluentinc/kafka-connect-s3:latest
17:23:49 ℹ️ 🤎 Listing jar files
accessors-smart-2.4.9.jar
aircompressor-2.0.3.jar
...
17:23:49 ℹ️ Searching for java class WebIdentityTokenCredentialsProvider in all jars
17:23:57 ℹ️ 👉 method signatures from ./auth-2.28.23.jar jar for class software.amazon.awssdk.auth.credentials.WebIdentityTokenCredentialsProviderFactory
Compiled from "WebIdentityTokenCredentialsProviderFactory.java"
public interface software.amazon.awssdk.auth.credentials.WebIdentityTokenCredentialsProviderFactory {
  public abstract software.amazon.awssdk.auth.credentials.AwsCredentialsProvider create(software.amazon.awssdk.auth.credentials.internal.WebIdentityTokenCredentialProperties);
}
```


