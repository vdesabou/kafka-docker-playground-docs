# playground topic dump-log

🔬 Dump the log segments of a partition: batches, producers, transactions

Runs kafka-dump-log on the segment files of a partition, in the broker  
that holds the replica (the leader by default), and prints a digest  
before the batches:

batches, records, offsets and time range of the segment(s) read  
compression codecs, largest batch (the max.message.bytes /  
RecordTooLargeException limit) and largest record  
producers (id, epochs, offsets), idempotent or transactional, with  
their COMMIT / ABORT markers  
open transactions: transactional records with no marker after them,  
where read_committed consumers stop (the last stable offset)

Then the batches: the last 20 (`--last`, `--all`), or the ones around  
`--offset`, with `--records` for each record (key and value sizes,  
headers) and `--print-data` for the payloads.

It reads the last (active) segment, the one that holds `--offset`, or  
every segment with `--all-segments`. The files are read on disk: no  
client credentials, any secured environment and cfk. Not on Confluent  
Cloud (no access to the log segments).

🎓 Tip: for a read_committed consumer stuck at an offset, or  
transactions that never end, look at the producers of that offset,  
then `playground broker transactions find-hanging`.

## Usage

```bash
playground topic dump-log [OPTIONS]
```

## Options

#### `--topic, -t TOPIC`

🗳 Topic name

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--partition, -p PARTITION`

🔢 Partition (default 0)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `0`

#### `--offset, -o OFFSET`

🎯 Read the segment that holds this offset, and show the batches around it

#### `--broker BROKER`

🖥️ Id of the broker whose replica to read (default: the leader)

#### `--all-segments`

📚 Read every segment of the partition, not only the last one (can be long on a big partition)

#### `--records`

🧾 Show each record of the batches shown: offset, key and value sizes, headers

#### `--print-data`

📄 With `--records`, show the payloads too (raw bytes as text: Avro and Protobuf are not decoded)

#### `--last LAST`

🔢 Number of batches to show, the last ones (default 20)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20`

#### `--all`

📦 Show every batch of the segment(s) read

#### `--raw`

📜 Print the output of kafka-dump-log as is

#### `--json`

📗 Print {"segments", "batches": [{..., "records"}], "summary": {..., "producers", "open_transactions"}} and nothing else

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground topic dump-log --topic orders
```

```bash
playground topic dump-log --topic orders --partition 2 --offset 15234 --records
```

```bash
playground topic dump-log --topic orders --all-segments --json | jq '.summary.open_transactions'
```

```bash
playground topic dump-log --topic orders --broker 2 --raw
```

## Example output

```text
$ playground topic dump-log --topic dumplog-test
16:04:55 ℹ️ 📂 dumplog-test-0 on broker 1 (leader) in broker: /var/lib/kafka/data/dumplog-test-0
16:04:55 ℹ️    1 segment(s): 00000000000000000000.log (782 KB); read: 00000000000000000000.log
16:04:55 ℹ️ 🧮 8 batch(es), 18 record(s), offsets 0-19, 2026-11-04 16:02:08 → 2026-11-04 16:02:52
16:04:55 ℹ️    compression: lz4 (1), none (5); largest batch 781.2 KB at offset 10, largest record value 781.2 KB at offset 10
16:04:55 ℹ️    transactions: 3 transactional batch(es), 1 COMMIT and 1 ABORT marker(s)
   producer 17 (epoch 0)  offsets 0-4, 5 record(s) in 1 batch(es), idempotent
   producer 18 (epoch 0)  offsets 5-9, 5 record(s) in 1 batch(es), idempotent
   producer 19 (epoch 0)  offsets 10-10, 1 record(s) in 1 batch(es), idempotent
   producer 21 (epochs 0,1)  offsets 11-14, 3 record(s) in 1 batch(es), transactional: 1 commit(s), 0 abort(s)
   producer 23 (epochs 0,1)  offsets 15-17, 2 record(s) in 1 batch(es), transactional: 0 commit(s), 1 abort(s)
   producer 25 (epoch 0)  offsets 18-19, 2 record(s) in 1 batch(es), transactional: 0 commit(s), 0 abort(s), ⚠️ open since offset 18
16:04:55 ❗ ⚠️ producer 25: transactional records from offset 18 with no COMMIT / ABORT marker after them in the segment(s) read: an open (or hanging) transaction. read_committed consumers stop before offset 18 (the last stable offset) until it ends
16:04:55 ❗    👉 playground broker transactions find-hanging (and describe-producers --topic 'dumplog-test'), then broker transactions abort if it never ends; a still running transaction is normal
16:04:55 ℹ️ 📦 last 20 batch(es)
   offsets        count  producer     kind             codec   size       CreateTime
   0-4            5      17/0         -                none    160 B      2026-11-04 16:02:08
   5-9            5      18/0         -                lz4     163 B      2026-11-04 16:02:12
   10             1      19/0         -                none    781.2 KB   2026-11-04 16:02:17
   11-13          3      21/0         transactional    none    121 B      2026-11-04 16:02:25
   14             1      21/1         ✅ COMMIT marker  none    78 B       2026-11-04 16:02:27
   15-16          2      23/0         transactional    none    100 B      2026-11-04 16:02:39
   17             1      23/1         ❌ ABORT marker   none    78 B       2026-11-04 16:02:41
   18-19          2      25/0         transactional    none    103 B      2026-11-04 16:02:52
```


