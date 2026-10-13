# playground get-ci-result

🤖 get CI result for current example  
  
Tells you whether the example you are running is green in the nightly CI,  
both for the default environment and for cfk, by reading the published  
badges from kafka-docker-playground.io.  
  
👉 Useful before you spend time debugging: if CI is red too, the breakage  
is probably not on your side. Reproduction models are always reported as  
fine, they are not part of the CI matrix.  
  
🔥 With --logs, also tells why it is red: the latest failing CI job of the  
example is located from its '🔥' GitHub issue, its full log is downloaded,  
and for each failing script the last lines before the failure are shown  
with a digest of the ERROR/FATAL records (same digest as 'playground  
container logs --errors').  
  
Use --test to ask about any example, without running it.

## Usage

```bash
playground get-ci-result [OPTIONS]
```

## Options

#### *--test, -t TEST*

📂 Example directory (or script) to check, instead of the current example  
  
Examples: connect/connect-aws-s3-sink, other/connect-secret-registry

#### *--environment ENVIRONMENT*

🔐 CI environment to check: plaintext or cfk  
  
Default is the environment of the current example, or plaintext with --test

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | plaintext, cfk

#### *--podman*

🦭 Check the podman CI run instead of the docker one

#### *--logs*

🔥 When CI is red, show why: tail and ERROR/FATAL digest of each failing script of the latest failing job

#### *--max-findings MAX_FINDINGS*

✂️ With --logs, maximum number of distinct records to show per failing script (default 20)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 20

## Examples

```bash
playground get-ci-result
```

```bash
playground get-ci-result --logs
```

```bash
playground get-ci-result --test other/connect-secret-registry --logs
```

```bash
playground get-ci-result --test connect/connect-mqtt-sink --environment cfk --podman --logs
```

## Example output

```text
$ playground get-ci-result --test connect/connect-http-sink
17:23:20 ℹ️ 🤖CI status: 🟢 ok
🔗test url: https://github.com/vdesabou/kafka-docker-playground/actions/runs/37858925089/job/113589742349
```

```text
$ playground get-ci-result --test connect/connect-replicator --logs --max-findings 2
17:24:15 ℹ️ 🔥 latest failure reported in https://github.com/vdesabou/kafka-docker-playground/issues/9054
   🔥 CP 8.3.2 🔢 Connector v7.3.2 (📅 release date 2023-02-25) 🕐 2026-10-13 00:45
   🔗 https://github.com/vdesabou/kafka-docker-playground/actions/runs/38328314041/job/115072055973
   🕐 run of 2026-10-13T00:39:22Z on commit 141b0aa0d

17:24:17 ℹ️ 🔥 replicator-2way-ssl.sh failed, last lines before the failure:
   00:45:48 ❗ ❌ topic test-topic-ssl-duplicate does not exist, retrying in 1 second (elapsed time: 59 seconds), waiting max for 60 seconds
   00:45:50 ❗ ❌ topic test-topic-ssl-duplicate does not exist !
   00:45:50 🔥 ####################################################

17:24:17 ℹ️ 🔎 ERROR/FATAL digest of replicator-2way-ssl.sh in the CI job
🔎 4 distinct record(s), 4 occurrence(s), in 797 lines

🔴 ERROR x1 (first seen line 717, last seen line 717)
[2026-10-13 00:44:31,858] ERROR [duplicate-topic-ssl|task-0] Failed to start task duplicate-topic-ssl-0 (org.apache.kafka.connect.runtime.Worker:1005)
        org.apache.kafka.common.KafkaException: Failed to construct kafka producer
        at org.apache.kafka.common.config.AbstractConfig.getConfiguredInstance(AbstractConfig.java:429)

✂️ 2 more distinct record(s) not shown, increase --max-findings
```


