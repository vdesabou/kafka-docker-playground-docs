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


