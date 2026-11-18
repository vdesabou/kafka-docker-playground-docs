# playground cloud-resources cost-reminder run

💸 Check now what your clouds cost over the last `--days` days and what still runs for you, as the weekly job does

Read-only.

## Usage

```bash
playground cloud-resources cost-reminder run [OPTIONS]
```

## Options

#### `--resource RESOURCE`

☁️ Cloud to check (default: ccloud only)

🎓 Tip: repeat it, `--resource` ccloud `--resource` aws `--resource` azure

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `ccloud`
| Allowed Values: | `ccloud`, `aws`, `azure`

#### `--threshold USD`

💵 Notify when your cost over `--days` is at least this many US dollars (0: notify every week)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `50`

#### `--days DAYS`

📆 Number of days of the cost period, ending today

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `7`

## Examples

```bash
playground cloud-resources cost-reminder run
```

```bash
playground cloud-resources cost-reminder run --resource ccloud --resource aws --days 30
```


