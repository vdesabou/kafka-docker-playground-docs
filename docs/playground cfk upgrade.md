# playground cfk upgrade

⬆️ Move every custom resource to another Confluent Platform version

Changes the tag of spec.image.application of each custom resource,  
controllers first, then kafka, connect, schema registry, ksqlDB, REST  
proxy and control center, and waits for CFK to roll each one before the  
next (playground cfk patch). Then prints the image of each pod and, for  
KRaft, the finalized metadata.version: the feature level stays at the old  
version until it is upgraded (kafka-features upgrade).

## Usage

```bash
playground cfk upgrade [OPTIONS]
```

## Options

#### `--to VERSION`

🎯 Confluent Platform version, for example 8.4.1

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--timeout SECONDS`

⏱️ How long to wait for the roll of each custom resource

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `1200`

## Examples

```bash
playground cfk upgrade --to 8.4.1
```


