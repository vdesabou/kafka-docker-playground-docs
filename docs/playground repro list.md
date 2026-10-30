# playground repro list

📋 List the reproduction models, newest first, with their case, status and last verdict

Reads the header of every model of reproduction-models (date, author,  
description, 🎯 expected, 💥 actual, 🎫 jira, 🩹 status), its base  
example, whether it is committed, and the last verdict recorded by  
`playground repro assert`. A model without a date in its header gets  
the date of the commit that added it; one without a description, the  
end of its file name.

Filters can be combined. Models with uncommitted changes are marked ✏️.

## Usage

```bash
playground repro list [OPTIONS]
```

## Options

#### `--mine`

👤 Only the models whose author is you (whoami)

#### `--case CASE`

🔮 Only the models of this case (6 digits at the start of the description, or in the file name)

#### `--status STATUS`

🩹 Only the models whose 🩹 status contains this text (open, fixed, not a bug…)

#### `--verdict VERDICT`

🧪 Only the models with this last verdict (none: never ended with `playground repro assert` here)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `reproduced`, `not-reproduced`, `none`

#### `--base EXAMPLE`

🧬 Only the models whose base example contains this text, for example connect-jdbc-sink

#### `--since SINCE`

📅 Only the models created since this number of days (90d) or this date (2026-01-31)

#### `--grep REGEX`

🔍 Only the models whose description, expected, actual, jira or path matches this regex (case insensitive)

#### `--uncommitted`

✏️ Only the models with uncommitted changes

#### `--limit NUMBER`

🔢 Number of models shown (default: 30, 0 for all)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `30`

#### `--json`

🤖 Print the models as JSON (every field, with the last verdict and its versions)

## Examples

```bash
playground repro list --mine --since 90d
```

```bash
playground repro list --case 123456
```

```bash
playground repro list --status open --base connect-cdc-oracle
```

```bash
playground repro list --grep "magic byte" --limit 0
```

```bash
playground repro list --verdict reproduced --json
```


