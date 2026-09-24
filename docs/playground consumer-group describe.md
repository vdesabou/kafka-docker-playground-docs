# playground consumer-group describe

🔬 Describe consumer group  
  
By default, shows the committed offset, log end offset and lag of  
every partition consumed by the group, followed by the total lag.  
Use --state for the coordinator, assignment strategy and state, and  
--members for the members and their assigned partitions.

## Usage

```bash
playground consumer-group describe [OPTIONS]
```

## Options

#### *--group, -g GROUP*

👥 Consumer group name  
  
ℹ️ If not set, all consumer groups are described

#### *--state*

🚦 Display state of the group (coordinator, assignment strategy, state, number of members)

#### *--members*

🧑‍🤝‍🧑 Display members of the group and their assigned partitions

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground consumer-group describe --group connect-http-sink
```

```bash
playground consumer-group describe --group my-app --members
```

```bash
playground consumer-group describe --group my-app --state
```


