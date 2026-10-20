# playground analyze cfk-bundle

📦 Analyze a Confluent for Kubernetes (CFK) support bundle

🔍 Checks Warning events, pods (phase, waiting reasons, restarts, OOMKilled), every platform.confluent.io custom resource (phase/state, ready replicas, False conditions, failed connector tasks) and the ERROR/FATAL records of every log (rotated and .gz included, with their Caused by chain and an occurrence count), sorts them into ~30 categories (pod failures, TLS, auth, MDS/RBAC, license, KRaft, replication, storage, scheduling, …) and prints concrete remediation steps per category.

🧭 Also prints the environment (Kubernetes version, CFK operator version, application / init image of every component, from cluster-details.txt and the CRs) and checks it against the CFK support matrix (Kubernetes, Confluent Platform and Control Center ranges, init container on the operator version), lists the recent changes (who edited which CR and when, from managedFields, StatefulSet rollouts, pod (re)starts) and flags a JVM default truststore (-Djavax.net.ssl.trustStore) set without its password, the cause of "trustAnchors parameter must be non-empty". One issue per root cause: the connector tasks it affects are listed with it.

✅ Works offline on any bundle produced by kubectl confluent support-bundle (or playground debug cfk generate-bundle): no cfk environment needed.

🔒 Sanitization (secrets / IPs / hostnames / emails / LDAP DNs) is ON by default. It is best effort: review the output before sharing it. Pass `--no-sanitize` only for internal/test bundles.

🔖 Accepts a directory or a .tar / .tar.gz / .tgz / .zip archive.

🔖 Use `--json` to emit machine-readable output for downstream tooling.

🧩 Each issue is attributed to a component (kafka, kraftcontroller, connect, schemaregistry, operator…) and to the instance (CR name, e.g. connect-peh) it comes from. Use `--component` to keep only some of them, or the Component / Instance buttons of the HTML report.

🌐 Prints the text digest and also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal.

🧪 With `--sample`, it analyzes the samples shipped in cfk-analysis/samples: a quick way to see what it reports.

🔖 Exit code is 0 when the analysis completed (whatever was found, read the summary), 64 for an invalid, unsafe or empty bundle.

## Usage

```bash
playground analyze cfk-bundle [OPTIONS]
```

## Options

#### `--bundle, -b PATH`

🗂️  Path to the CFK support bundle (directory or .tar/.tar.gz/.tgz/.zip)

#### `--sample, -s SAMPLE`

🧪 Sample of cfk-analysis/samples

- **synthetic**: CFK bundle: kafka-2 crash-looping on an expired certificate, pending volume, OOMKilled Connect pod, failed connector task, Schema Registry authentication failure, operator reconcile errors

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `synthetic`

#### `--json`

📄 Emit machine-readable JSON (includes per-issue recommendation) instead of the text report

#### `--no-sanitize`

⚠️  Disable sanitization of IPs, hostnames, emails, and credentials.

🚫 NEVER use this for customer bundles. Internal/test bundles only.

#### `--severity LEVEL`

🎚️  Filter issues by minimum severity (critical | high | medium | low)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `critical`, `high`, `medium`, `low`

#### `--component COMPONENT`

🧩 Only keep the issues of this component (repeat `--component` for several). other = not a CFK component (nodes, volumes, unknown pods)

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Allowed Values: | `kafka`, `kraftcontroller`, `zookeeper`, `connect`, `schemaregistry`, `ksqldb`, `controlcenter`, `kafkarestproxy`, `operator`, `other`

#### `--top N`

🔢 Max number of issues to display per category in text mode (default: 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--include-warnings`

⚠️  Also report WARN log records that match no known category (WARN records matching a known category are always reported)

#### `--output-dir DIR`

📁 Directory for the HTML report (default: ./cfk-reports)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./cfk-reports`

## Examples

```bash
playground analyze cfk-bundle --sample synthetic
```

```bash
playground analyze cfk-bundle --bundle ./customer-bundle.tar.gz
```

```bash
playground analyze cfk-bundle --bundle ./extracted-bundle/
```

```bash
playground analyze cfk-bundle --bundle ./bundle.zip --severity high
```

```bash
playground analyze cfk-bundle --bundle ./bundle.tar --component connect
```

```bash
playground analyze cfk-bundle --bundle ./bundle.tar.gz --json > report.json
```

```bash
playground analyze cfk-bundle -b ./bundle.tgz --output-dir ./reports
```

```bash
playground analyze cfk-bundle -b ./bundle.tgz --include-warnings
```


