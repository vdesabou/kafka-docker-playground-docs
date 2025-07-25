# playground connector logs

🕵️  Tail and follow connect logs  
  
For onprem connectors, this is basically a shortcut for "playground container logs --container connect", --connector flag is not relevant  
  
For Fully Managed connectors, limitations apply (see https://docs.confluent.io/cloud/current/connectors/logging-cloud-connectors.html#using-ccloud-cli)

## Usage

```bash
playground connector logs [OPTIONS]
```

## Options

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--open, -o*

🔖 Save output to a file and open with text editor set with playground config editor \<editor\> (default is code)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--wait-for-log*

#### *--wait-for-log, -w LOG*

😴 Wait until log appears

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--open*

#### *--verbose, -v*

🐞 Show command being ran.


