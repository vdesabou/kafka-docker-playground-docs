# playground connector log-level

🧬 Set connect log level

Raises the log level for the packages of the connector that is running,  
without restarting anything. Set it to TRACE, reproduce the problem,  
then read `playground connector logs`.

This is the difference between "the task failed" and seeing the request  
that failed, the record that broke and what the SMT chain did to it.

🎓 Tip: it will also set io.confluent.kafka.schemaregistry.client.rest.RestService (to see schema registry rest requests) and org.apache.kafka.connect.runtime.TransformationChain (to see records before and after SMTs)  
it will also set org.apache.kafka.connect.runtime.WorkerSinkTask for sink and org.apache.kafka.connect.runtime.WorkerSourceTask for source connectors.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-log-levels  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%A7%AC-trace-on-a-running-connector-without-a-restart

## Usage

```bash
playground connector log-level [OPTIONS]
```

## Options

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--level, -l LEVEL`

❕Log level

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `INFO`, `WARN`, `DEBUG`, `TRACE`

#### `--cluster CLUSTER`

🌍 Cluster to use in an mdc-\* environment (us or europe)

Default: the `PLAYGROUND_CLUSTER` environment variable, else the value set with `playground state set run.cluster <cluster>`. Ignored in the other environments.

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `us`, `europe`


