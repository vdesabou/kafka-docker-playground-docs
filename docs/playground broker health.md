# playground broker health

🩺 Check the health of the cluster

One digest of what makes a cluster unhealthy:

- broker containers that are not registered (stopped, starting) or fenced
- under-replicated partitions (kafka-topics `--under-replicated-partitions`)
- partitions under min.insync.replicas (`--under-min-isr-partitions`):

acks=all producers fail with NotEnoughReplicasException (a topic  
whose replication factor is below min.insync.replicas is only a ⚠️  
warning: it is a config problem, not a broker one)

- unavailable partitions, without leader (`--unavailable-partitions`)
- the KRaft quorum: leader, lag and last caught up time of each node

(kafka-metadata-quorum describe `--replication`)

Exits with 1 when the cluster is not healthy. With `--wait-healthy`, waits  
until it is (for example after `playground broker start` or a  
'container restart'), up to `--max-wait` seconds.

Works on plaintext, secured environments and cfk.

## Usage

```bash
playground broker health [OPTIONS]
```

## Options

#### `--wait-healthy`

⏳ Wait until the cluster is healthy (up to `--max-wait` seconds)

#### `--max-wait MAX-WAIT`

⏳ Maximum time to wait with `--wait-healthy`, in seconds (default 120)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `120`

#### `--json`

📗 Print the result as JSON (healthy, brokers, partitions, kraft_quorum), and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground broker health
```

```bash
playground broker health --wait-healthy --max-wait 300
```

```bash
playground broker health --json | jq '.under_replicated_partitions | length'
```

## Example output

```text
$ playground broker health
17:42:10 ℹ️ 🩺 Health of the cluster
17:42:11 ℹ️ 🖥️ registered brokers: 1,3
17:42:11 ❌ broker 2 (container broker2) is not registered: it is stopped (playground broker start --broker 2)
17:42:13 ❌ 3 under-replicated partitions
TOPIC     PARTITION  LEADER  REPLICAS  ISR
orders    0          1       1,2,3     1,3
orders    1          3       2,3,1     3,1
orders    2          1       3,1,2     3,1
17:42:15 ℹ️ ✅ no under min.insync.replicas partition
17:42:17 ℹ️ ✅ no unavailable (no leader) partition
17:42:19 ℹ️ 🗳️ KRaft quorum: leader is node 4
NODE  STATUS    LOG_END_OFFSET  LAG  LAST_CAUGHT_UP
4     Leader    1250            0    0s ago
1     Observer  1250            0    0s ago
2     Observer  1100            150  85s ago ⚠️
3     Observer  1250            0    0s ago
17:42:19 ❌ cluster is not healthy: brokers down: 2, 3 under-replicated partitions
```


