# playground connector diagnose

🩺 Diagnose a connector in one call: status, errors and progress  
  
Chains the commands you would run one after the other when a connector  
misbehaves, and returns:  
  
  🗺️  status       connector and task states, with the trace of a failed task  
  🔥 errors       digest of the connect ERROR/FATAL records (self-managed),  
                  or Confluent Cloud error recommendations (fully managed)  
  🐢 progress     consumer lag of a sink, or offsets of a source  
  👉 next steps   the commands to dig further  
  
It never follows logs and never waits for the lag to reach 0, so it is  
safe to use from scripts and AI agents.

## Usage

```bash
playground connector diagnose [OPTIONS]
```

## Options

#### *--verbose, -v*

🐞 Show command being ran.

#### *--connector, -c CONNECTOR*

🔗 Connector name  
  
🎓 Tip: If not specified, the command will apply to all connectors

#### *--since SINCE*

🕐 Only look at connect logs newer than this (default 1h). Docker durations: 10m, 2h... (self-managed only)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1h

#### *--max-findings MAX_FINDINGS*

✂️ Maximum number of distinct error records to show (default 15)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 15

## Examples

```bash
playground connector diagnose
```

```bash
playground connector diagnose --connector http-sink
```

```bash
playground connector diagnose --connector http-sink --since 10m --max-findings 5
```

## Example output

```text
$ playground connector diagnose
17:22:06 ℹ️ 🩺 diagnosing 🌎onprem connector filestream-sink

17:22:06 ℹ️ 🗺️  1/4 status
17:22:07 ℹ️ 🧩 Displaying status for 🌎onprem connector filestream-sink
Name                           Status       Tasks                                                        Stack Trace
-------------------------------------------------------------------------------------------------------------
filestream-sink                ✅ RUNNING  0:🟢 RUNNING                 -
-------------------------------------------------------------------------------------------------------------

17:22:07 ℹ️ 🔥 2/4 errors: digest of connect ERROR/FATAL records since 1h (whole worker, not only this connector)
✅ no ERROR/FATAL record found in 12523 lines

17:22:07 ℹ️ 🐢 3/4 progress: consumer lag of sink filestream-sink
topic: filestream partition: 0   current-offset: 5          end-offset: 5          lag: 0          [🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹] 100% 🏁

17:22:10 ℹ️ 👉 4/4 next steps
   🐌 RUNNING but no progress? run this command again, then take a thread dump if lag or offsets do not move
   playground connector show-config --connector filestream-sink
   playground container logs -c connect --grep "filestream-sink" --no-follow --tail 200
   playground debug log-level set --package <connector package> --level TRACE
   playground debug thread-dump --container connect
```


