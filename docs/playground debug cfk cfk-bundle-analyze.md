# playground debug cfk cfk-bundle-analyze

📦 Analyze a Confluent for Kubernetes (CFK) support bundle  
  
🔍 Scans pod describes, events, component CRs, and logs for ~30 issue categories (pod failures, TLS, auth, MDS/RBAC, license, KRaft, replication, storage, scheduling, …) and prints concrete remediation steps per category.  
  
🔒 Sanitization (IPs / hostnames / emails / secrets) is ON by default — pass --no-sanitize only for internal/test bundles.  
  
🔖 Accepts a directory or a .tar / .tar.gz / .tgz / .zip archive.  
  
🔖 Use --json to emit machine-readable output for downstream tooling.

## Usage

```bash
playground debug cfk cfk-bundle-analyze [OPTIONS]
```

## Options

#### *--bundle, -b PATH*

🗂️  Path to the CFK support bundle (directory or .tar/.tar.gz/.tgz/.zip)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--json*

📄 Emit machine-readable JSON (includes per-issue recommendation) instead of the text report

#### *--no-sanitize*

⚠️  Disable sanitization of IPs, hostnames, emails, and credentials.  
  
🚫 NEVER use this for customer bundles. Internal/test bundles only.

#### *--severity LEVEL*

🎚️  Filter issues by minimum severity (critical | high | medium | low)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | critical, high, medium, low

#### *--top N*

🔢 Max number of issues to display per category in text mode (default: 5)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 5

#### *--html*

🌐 Generate a self-contained HTML report and open it in the default browser  
  
❕ No external CDN/network needed — single offline-viewable file you can share.

#### *--output-dir DIR*

📁 Directory for the HTML report (default: ./cfk-reports). Only used with --html.

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | ./cfk-reports

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


