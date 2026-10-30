# playground broker rolling-restart

🔄 Restart the brokers one by one, like a rolling upgrade

Checks that the cluster is healthy (`--force` to skip), then for each  
broker: restarts its container (controlled shutdown), waits for it to be  
registered and for the cluster to be healthy again before the next one.  
Stops at the first broker that does not come back healthy within  
`--max-wait` seconds.

Useful to reproduce connector or client errors, duplicates or rebalances  
during a rolling upgrade or restart of the brokers.

🎓 Tip: to change a broker setting that needs a restart, use 'playground  
container set-environment-variables' (it recreates the container).

## Usage

```bash
playground broker rolling-restart [OPTIONS]
```

## Options

#### `--brokers BROKERS`

🖥️ Comma separated broker ids, restarted in this order (default: all brokers, by id)

#### `--max-wait MAX-WAIT`

⏳ Maximum time to wait for each broker to be back and the cluster healthy, in seconds (default 300)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `300`

#### `--force`

☢️ Restart even if the cluster is not healthy before starting

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground broker rolling-restart
```

```bash
playground broker rolling-restart --brokers 3,2,1 --max-wait 600
```

## Example output

```text
$ playground broker rolling-restart
17:50:02 ℹ️ 🔄 [1/3] Restarting broker 1 (container broker)
17:50:31 ℹ️ ✅ [1/3] broker 1 restarted, cluster is healthy (29s)
17:50:31 ℹ️ 🔄 [2/3] Restarting broker 2 (container broker2)
17:50:58 ℹ️ ✅ [2/3] broker 2 restarted, cluster is healthy (27s)
17:50:58 ℹ️ 🔄 [3/3] Restarting broker 3 (container broker3)
17:51:26 ℹ️ ✅ [3/3] broker 3 restarted, cluster is healthy (28s)
17:51:26 ℹ️ 🎉 rolling restart of brokers 1,2,3 done in 84s
```


