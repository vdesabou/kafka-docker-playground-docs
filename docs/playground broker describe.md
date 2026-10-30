# playground broker describe

🗺️ Describe the cluster

The brokers (id, endpoint, rack, fenced, container, and the broker  
containers that are not registered), the KRaft quorum (cluster id,  
active controller, voters and observers, from kafka-metadata-quorum  
describe `--status`) and the feature levels (metadata.version... from  
kafka-features describe).

With `--api-versions`, the API versions supported by a broker (wraps  
kafka-broker-api-versions): useful when an old client fails with  
UnsupportedVersionException.

## Usage

```bash
playground broker describe [OPTIONS]
```

## Options

#### `--api-versions`

🔌 Display the API versions supported by a broker instead

#### `--broker, -b BROKER`

🖥️ Broker id for `--api-versions` (default: the first broker)

#### `--verbose, -v`

🐞 Show command being ran.

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`

## Examples

```bash
playground broker describe
```

```bash
playground broker describe --api-versions --broker 2
```


