# playground broker config

⚙️ Dynamic broker config commands

Read and change the configuration of the running brokers, without  
restart (wraps kafka-configs `--entity-type` brokers). Works on plaintext,  
secured environments and cfk (not on Confluent Cloud, where broker  
configs can't be changed).

- **get**: dynamic configs, or the value and source of one key
- **set**: set a key, cluster-wide or on one broker
- **delete**: remove a dynamic value (back to the static or default one)

Without `--broker`, set and delete apply to the cluster-wide default,  
used by every broker without its own value. Only the configs marked  
"dynamic" (per-broker or cluster-wide) in the broker configuration  
reference can be changed: kafka-configs refuses the others.

🎓 Tip: changing a broker environment variable with 'playground  
container set-environment-variables' also works for the read-only  
configs, but recreates the container.

## Usage

```bash
playground broker config COMMAND
```

## Kafka commands

- [get](playground%20broker%20config%20get) - 🔎 Display dynamic broker configs
- [set](playground%20broker%20config%20set) - ⚙️ Set a dynamic broker config
- [delete](playground%20broker%20config%20delete) - 🗑️ Remove a dynamic broker config


