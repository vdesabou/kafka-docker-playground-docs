# playground cloud-resources cost-reminder enable

💸 Schedule the weekly cost reminder, then run it once now

Run it again to change the day, the time, the clouds or the threshold.  
The job uses this checkout of the playground and the PATH of the shell  
you run it from.

## Usage

```bash
playground cloud-resources cost-reminder enable [OPTIONS]
```

## Options

#### `--day DAY`

📅 Day of the week of the run

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `monday`
| Allowed Values: | `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`

#### `--time TIME`

🕘 Time of the run, HH:MM, local time

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `09:00`

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
playground cloud-resources cost-reminder enable
```

```bash
playground cloud-resources cost-reminder enable --resource ccloud --resource aws --threshold 20
```

```bash
playground cloud-resources cost-reminder enable --day friday --time 17:00 --days 14
```


