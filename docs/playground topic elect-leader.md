# playground topic elect-leader

👑 Elect the leaders of a topic

Wraps kafka-leader-election. By default, a preferred leader  
election: each partition gets back its first replica as leader (what  
auto.leader.rebalance.enable does every 5 minutes).

With `--leader`, a controlled leadership move: the broker is first put  
first in the replicas of the partitions (a reassignment without data  
movement, it must already be a replica), then elected. Useful to  
reproduce a leader change (`NOT_LEADER_OR_FOLLOWER`, metadata refresh)  
without stopping a broker.

`--unclean` elects a replica that is not in sync when no in-sync  
replica is available (data loss).

## Usage

```bash
playground topic elect-leader [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--partition, -p PARTITION`

🔢 Only this partition (default: all the partitions of the topic)

#### `--leader BROKER`

👑 Broker id to make leader (it must be a replica of the partition)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--unclean`

#### `--unclean`

☢️ Unclean leader election (an out-of-sync replica can become leader)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--leader`

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground topic elect-leader --topic orders
```

```bash
playground topic elect-leader --topic orders --partition 0 --leader 2
```

```bash
playground topic elect-leader --topic orders --unclean
```


