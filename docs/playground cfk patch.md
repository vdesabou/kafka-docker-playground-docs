# playground cfk patch

🩹 Change a custom resource and wait for CFK to roll it

`kubectl patch <kind>/<name> in the confluent namespace (a JSON merge`  
patch by default), then waits for the operator: the statefulset of the  
custom resource changed or not, every pod restarted on the new revision  
and Ready, the custom resource back to phase RUNNING. Prints the events  
of the custom resource and its pods since the change.

A configOverrides list replaces the whole list with a merge patch: give  
every property, or use `--type` json with an "add" operation.

## Usage

```bash
playground cfk patch RESOURCE PATCH [OPTIONS]
```

## Arguments

#### `RESOURCE`

🎯 kind/name of the custom resource, for example kafka/kafka, connect/connect, kraftcontroller/kraftcontroller

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `PATCH`

🩹 The patch, JSON or YAML

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### `--type TYPE`

🧩 Patch type (kubectl patch `--type`)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `merge`
| Allowed Values: | `merge`, `json`, `strategic`

#### `--timeout SECONDS`

⏱️ How long to wait for the roll

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `900`

#### `--no-wait`

🏃 Only patch, don't wait for the roll

## Examples

```bash
playground cfk patch kafka/kafka '{"spec": {"configOverrides": {"server": ["log.retention.hours=72"]}}}'
```

```bash
playground cfk patch connect/connect '{"spec": {"replicas": 2}}'
```

```bash
playground cfk patch kafka/kafka '[{"op": "add", "path": "/spec/configOverrides/server/-", "value": "num.io.threads=16"}]' --type json
```


