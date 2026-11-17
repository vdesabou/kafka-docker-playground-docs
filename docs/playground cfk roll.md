# playground cfk roll

🔁 Restart the pods of a custom resource, the way CFK supports

Kafka and KRaft: a new value of the annotation kafkacluster-manual-roll in  
spec.podTemplate, the only supported way to restart them: CFK rolls one  
pod at a time, with its health checks (no under-replicated partitions).  
The other components: kubectl rollout restart of their statefulset.  
Waits for the roll like playground cfk patch.

When to use: a change in a Secret (credentials, license), or a change of  
the custom resource the pods did not get.

## Usage

```bash
playground cfk roll RESOURCE [OPTIONS]
```

## Arguments

#### `RESOURCE`

🎯 kind/name of the custom resource, for example kafka/kafka, connect/connect

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### `--timeout SECONDS`

⏱️ How long to wait for the roll

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `900`

## Examples

```bash
playground cfk roll kafka/kafka
```

```bash
playground cfk roll connect/connect
```


