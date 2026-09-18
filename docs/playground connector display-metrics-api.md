# playground connector display-metrics-api

〽️ Display metrics api for fully managed connector  
  
Queries the Confluent Cloud Telemetry API for the connector: a summary  
with the connector and task statuses, then every metric that is not  
zero. A fully managed connector gives you no jmx and little logging, so  
this is how you tell whether it is actually doing work.  
  
See https://api.telemetry.confluent.cloud/docs/descriptors/datasets/cloud

## Usage

```bash
playground connector display-metrics-api [OPTIONS]
```

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--wait-for-log, --grep*

#### *--verbose, -v*

🐞 Show command being ran.


