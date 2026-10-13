# playground debug cfk cfk-bundle-analyze

📦 Analyze a Confluent for Kubernetes (CFK) support bundle

🔍 Checks Warning events, pods (phase, waiting reasons, restarts, OOMKilled), every platform.confluent.io custom resource (phase/state, ready replicas, False conditions, failed connector tasks) and the ERROR/FATAL records of every log (rotated and .gz included, with their Caused by chain and an occurrence count), sorts them into ~30 categories (pod failures, TLS, auth, MDS/RBAC, license, KRaft, replication, storage, scheduling, …) and prints concrete remediation steps per category.

✅ Works offline on any bundle produced by kubectl confluent support-bundle (or playground debug cfk generate-bundle): no cfk environment needed.

🔒 Sanitization (secrets / IPs / hostnames / emails / LDAP DNs) is ON by default. It is best effort: review the output before sharing it. Pass `--no-sanitize` only for internal/test bundles.

🔖 Accepts a directory or a .tar / .tar.gz / .tgz / .zip archive.

🔖 Use `--json` to emit machine-readable output for downstream tooling.

🔖 Exit code is 0 when the analysis completed (whatever was found, read the summary), 64 for an invalid, unsafe or empty bundle.

## Usage

```bash
playground debug cfk cfk-bundle-analyze [OPTIONS]
```

## Options

#### `--bundle, -b PATH`

🗂️  Path to the CFK support bundle (directory or .tar/.tar.gz/.tgz/.zip)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

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

#### `--top N`

🔢 Max number of issues to display per category in text mode (default: 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `5`

#### `--include-warnings`

⚠️  Also report WARN log records that match no known category (WARN records matching a known category are always reported)

#### `--html`

🌐 Generate a self-contained HTML report and open it in the default browser

❕ No external CDN/network needed — single offline-viewable file you can share.

#### `--output-dir DIR`

📁 Directory for the HTML report (default: ./cfk-reports). Only used with `--html`.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `./cfk-reports`

## Examples

```bash
playground debug cfk cfk-bundle-analyze --bundle ./customer-bundle.tar.gz
```

```bash
playground debug cfk cfk-bundle-analyze --bundle ./extracted-bundle/
```

```bash
playground debug cfk cfk-bundle-analyze --bundle ./bundle.zip --severity high
```

```bash
playground debug cfk cfk-bundle-analyze --bundle ./bundle.tar.gz --json > report.json
```

```bash
playground debug cfk cfk-bundle-analyze -b ./bundle.tgz --html
```

```bash
playground debug cfk cfk-bundle-analyze -b ./bundle.tgz --html --output-dir ./reports
```

```bash
playground debug cfk cfk-bundle-analyze -b ./bundle.tgz --include-warnings
```


