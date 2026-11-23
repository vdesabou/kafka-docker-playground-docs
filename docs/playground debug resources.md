# playground debug resources

🏋️ Limit the cpus and memory of a running container, or fill its disk: OOM, GC pressure, disk full

Some issues only happen when a component runs short of resources: an  
OOM kill (exit 137), a JVM spending its time in garbage collection, a  
starved connect worker missing its heartbeats, a broker that stops  
with 'KafkaStorageException' when its log dir is full. This changes  
the limits of a running container right away (docker update), without  
a restart, and fills its disk to a percentage.

- `--cpus 0.5`: at most half a cpu
- `--memory 1g`: at most 1g of memory, no swap: above, the kernel kills the process (OOMKilled, exit 137)
- `--fill-disk 95%`: fills the filesystem of `--path` to 95%
- `--reset`: back to the original limits, the fill file removed
- **(no flag)**: the limits, the usage, the JVM max heap, OOM kills and the disk of `--path`

`--path` defaults to log.dirs for a broker or a controller, /tmp  
otherwise. The fill file is a single file (.playground-fill-disk) in  
that folder: `--reset` removes it, the data stays.

❕ On Docker Desktop, a data folder (an anonymous volume) and /tmp are  
on the disk of Docker itself, shared by every container and image:  
`--fill-disk` refuses to fill it. Give the folder a filesystem of its  
own in the docker-compose override of the example, then fill it:

broker:  
tmpfs:

- /var/lib/kafka/data:size=2g,mode=1777

A tmpfs is memory: its content counts in the memory of the container.

❕ The JVM sizes its heap when it starts (`-Xmx`): a memory limit  
below `-Xmx` plus the off-heap memory gets the container OOM killed  
rather than an OutOfMemoryError. A recreate ('container recreate',  
'debug clock', a new run) drops the limits.

🧪 Docker only (not cfk).

## Usage

```bash
playground debug resources [OPTIONS]
```

## Options

#### `--container, -c, --pod, -p CONTAINER`

🐳 container name (or pod name when cfk environment is used)

🎓 Tip: you can pass multiple containers by specifying `--container` multiple times

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `connect`

#### `--cpus CPUS`

⚙️ Number of cpus the container can use, e.g. 0.5, 2

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--reset`

#### `--memory MEMORY`

🧠 Memory limit, without swap, e.g. 512m, 1g (b, k, m, g)

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--reset`

#### `--fill-disk PERCENT`

💾 Fill the filesystem of `--path` up to this percentage, e.g. 95%, 100%

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--reset`

#### `--path PATH`

📁 Folder whose filesystem `--fill-disk` fills (default: log.dirs for a broker or a controller, /tmp otherwise)

#### `--reset`

🧽 Back to the original cpu and memory limits, and remove the fill file

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--cpus`, `--memory`, `--fill-disk`

## Examples

```bash
playground debug resources --container connect --memory 1g
```

```bash
playground debug resources --container connect --cpus 0.5 --memory 2g
```

```bash
playground debug resources --container broker --fill-disk 95%
```

```bash
playground debug resources --container connect --fill-disk 100% --path /tmp
```

```bash
playground debug resources --container connect
```

```bash
playground debug resources --container connect --container broker --reset
```

## Example output

```text
$ playground debug resources --container connect --memory 1g
11:26:00 ℹ️ 🏋️ limiting connect: 1g memory (no swap)
11:26:00 ❗ 💀 the JVM of connect can grow its heap to -Xmx2G, more than the 1g limit: expect an OOM kill (exit 137, OOMKilled) before any OutOfMemoryError
11:26:00 ℹ️ 🏋️ connect: cpus no limit (18 on the docker host), memory 1.0GiB
11:26:02 ℹ️ 📊 usage now: 2.46% cpu, 971.1MiB / 1GiB memory (94.83%)
11:26:02 ℹ️ ☕ JVM max heap (-Xmx): 2G
11:26:02 ℹ️ 💾 disk of /tmp: 15% used, 266.6GiB of 1.7TiB, 1.4TiB free
11:26:02 ℹ️ 🧽 back to the original limits: playground debug resources --container connect --reset
```

```text
$ playground debug resources --container connect --fill-disk 95%
11:26:07 🔥 ❌ /tmp of connect is on the disk of docker itself (1.8TiB), shared by every container and image: filling it to 95% would fill all of them
11:26:07 🔥    🎓 give /tmp a filesystem of its own in the docker-compose override of the example, then run this command again:
  connect:
    tmpfs:
      - /tmp:size=2g,mode=1777
```


