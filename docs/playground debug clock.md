# playground debug clock

⏰ Shift the clock of a container: token, ticket and certificate expiry, time based partitioning

Some bugs only show up at a given time, or after a while: an OAuth  
token or a Kerberos ticket that expires, a certificate past its  
validity, the hourly rollover of TimeBasedPartitioner (S3, GCS,  
Azure, HDFS sinks), daylight saving time, clock skew between connect  
and the brokers. This moves the clock of one container (or several)  
forward or backward, the other containers keep the real time.

- `--offset +2h`: shift by a duration (s, m, h, d, y); backward: `--offset`=-30m (with =, a value starting with - is read as an option otherwise)
- `--at <date>`: jump to a date ("2026-12-31 23:59:50", UTC unless a Z or +02:00 offset is given), then the clock ticks
- `--reset`: back to real time (the container is recreated with its original definition)
- **(no flag)**: the time of the container, and its offset

libfaketime is preloaded in the container (`LD_PRELOAD`): the first call  
recreates the container once, the next ones only rewrite the offset,  
read again every second by every process of the container (the JVM  
included), without a restart. The monotonic clock is not shifted, so  
sleeps and elapsed time measurements keep working.

libfaketime is built once per architecture (amd64, arm64), in a UBI8  
container, and cached in /tmp/playground-faketime: it loads in the  
UBI8 (CP 7) and UBI9 (CP 8) images, not in musl (alpine) ones.

The recreate goes through 'container set-environment-variables': the  
values set before on the container (by it, 'debug java-debug' or  
'debug jscissors `--restart`') are kept. `--reset` gives the container  
its original definition back: those values go too. A jump forward fires at once the timeouts based on wall  
clock time: expect reconnections, a rebalance or a token refresh.

🧪 Docker only (not cfk).

## Usage

```bash
playground debug clock [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--offset OFFSET`

⏩ Shift of the clock: seconds, or a number with a unit s, m, h, d, y (e.g. +2h, +1d; backward: `--offset`=-30m)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--at`, `--reset`

#### `--at AT`

📅 Date to jump to, the clock ticks from there: "YYYY-MM-DD HH:MM:SS" (UTC), with an optional Z or +02:00 offset

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--offset`, `--reset`

#### `--reset`

🧽 Back to real time (the container is recreated with its original definition)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--offset`, `--at`

## Examples

```bash
playground debug clock --container connect --offset +2h
```

```bash
playground debug clock --container connect --at "2026-12-31 23:59:50"
```

```bash
playground debug clock --container connect --container broker --offset=-10m
```

```bash
playground debug clock --container connect
```

```bash
playground debug clock --container connect --reset
```

## Example output

```text
$ playground debug clock --container connect --offset +2h
08:54:26 ℹ️ 🔁 recreating connect with libfaketime (once: then the clock changes without a restart)
08:54:34 ℹ️ 🚦 containers have started! (took 6 seconds)
08:54:35 ℹ️ 🕰️ connect: 2026-11-19 09:54:35 UTC (real 2026-11-19 07:54:34 UTC, offset +2h)
08:54:35 ❗ ⏩ a jump forward fires the timeouts based on wall clock time at once (sessions, token and ticket lifetimes, metadata max age): expect reconnections, a rebalance, a token refresh
08:54:38 ❗ 🚫 the brokers refuse records more than log.message.timestamp.after.max.ms=3600000 ms in the future (InvalidTimestampException): connect cannot produce, and a connect worker stops (Error writing session key to Kafka) and restarts in a loop
08:54:38 ❗    🎓 shift the brokers too (--container broker), or: playground broker config set --key log.message.timestamp.after.max.ms --value 9223372036854775807
08:54:38 ℹ️ 🧽 back to real time: playground debug clock --container connect --reset
```

```text
$ playground debug clock --container connect --at "2026-12-31 23:59:50"
08:55:52 ℹ️ 🕰️ connect: 2026-12-31 23:59:52 UTC (real 2026-11-19 07:55:52 UTC, offset +3686640)
```


