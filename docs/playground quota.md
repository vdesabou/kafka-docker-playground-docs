# playground quota

🚦 Client quota commands

Read, set and remove the client quotas of the brokers (wraps kafka-configs  
`--entity-type` users|clients): produce and fetch bandwidth, request time  
and partition mutation rate. Works on plaintext, secured environments and  
cfk (not on Confluent Cloud, where quotas are managed with the client  
quotas API).

- **get**: quotas of a user, client id or connector, or all of them
- **set**: set one or more quotas
- **delete**: remove quotas

A quota applies to `--user`, `--client-id`, or both (the quota of that client  
id for that user only). `--all-users` / `--all-client-ids` set the default  
quota, used by every user / client id without a more specific one.  
`--connector` targets the client ids of the tasks of a self-managed  
connector: connector-consumer-`<connector>`-`<task>` for a sink,  
connector-producer-`<connector>`-`<task>` for a source.

🎓 Tip: to reproduce a throttled sink connector (lag growing,  
fetch-throttle-time-avg above 0), set a small `--consumer-byte-rate` on it,  
then follow the lag with `playground connector show-lag`.

## Usage

```bash
playground quota COMMAND
```

## Kafka commands

- [get](playground%20quota%20get) - 🔎 Display client quotas
- [set](playground%20quota%20set) - 🚦 Set client quotas
- [delete](playground%20quota%20delete) - 🗑️ Remove client quotas


