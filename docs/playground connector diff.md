# playground connector diff

🔀 Diff the config of a running connector with another config

Compares the config of a running connector, key by key, with:

- **stdin**: a config (plain json, or the heredoc printed by 'show-config')
- `--file`: the same, from a file, e.g. the config of a customer
- `--with-connector`: another running connector
- `--defaults`: the default value of each parameter of the plugin: shows only what the connector changes, and the keys set to their default that could be removed

Keys only on one side, and keys with different values, are listed.  
Passwords masked by the REST API are not compared.

🎓 Tip: run it with the config of a customer and the config of the  
example to see right away what differs.

🌐 Also writes a self-contained HTML report in `--output-dir`, opened in the browser in an interactive terminal (`--no-open` to skip): the keys side by side with the documentation, type and default of each one (from the configuration reference of the plugin), what the important differences mean (converters, error handling, transforms...), and the secrets masked.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-connector-create-or-update

## Usage

```bash
playground connector diff [OPTIONS]
```

## Options

#### `--verbose, -v`

🐞 Show command being ran.

#### `--connector, -c CONNECTOR`

🔗 Connector name

🎓 Tip: If not specified, the command will apply to all connectors

#### `--file, -f FILE`

📄 File with the config to compare with (json, or a create-or-update heredoc)

#### `--with-connector WITH_CONNECTOR`

🔗 Other running connector to compare with

#### `--defaults`

💤 Compare with the default value of each parameter of the plugin

#### `--json`

🤖 Print the result as JSON (no HTML report)

#### `--output-dir, -o OUTPUT_DIR`

📂 Output directory for the HTML report (default: /tmp/playground-connector-diff)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `/tmp/playground-connector-diff`

#### `--no-open`

🙈 Do not open the HTML report in the browser

## Examples

```bash
playground connector diff --connector filestream-sink --file customer-config.json
```

```bash
playground connector diff --connector filestream-sink --with-connector filestream-sink2
```

```bash
playground connector diff --connector filestream-sink --defaults
```

```bash
playground connector diff --connector filestream-sink << EOF
{
  "connector.class": "FileStreamSink",
  "topics": "filestream",
  "file": "/tmp/output.json"
}
EOF
```

## Example output

```text
$ playground connector diff --connector filestream-sink --file customer-config.json
17:22:05 ℹ️ 🔀 Diff of connector filestream-sink (➖) with customer-config.json (➕)
  ✏️  tasks.max
       ➖ 1
       ➕ 4
  ➕ errors.tolerance = all   (only in customer-config.json)
17:22:05 ℹ️ 📊 2 key(s) differ, 6 identical
17:22:05 ℹ️ ✅ HTML report saved: /tmp/playground-connector-diff/diff-filestream-sink-customer-config.json-20261013-172205.html
17:22:05 ℹ️ 🔗 Open in browser: file:///tmp/playground-connector-diff/diff-filestream-sink-customer-config.json-20261013-172205.html
```


