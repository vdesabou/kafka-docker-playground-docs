# playground cloud-resources nightly-cleanup enable

🌙 Schedule the nightly cleanup, then show what tonight's run would delete

Run it again to change the time or the clouds. The job uses this  
checkout of the playground and the PATH of the shell you run it from.

## Usage

```bash
playground cloud-resources nightly-cleanup enable [OPTIONS]
```

## Dependencies

#### *confluent*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install

## Options

#### `--time TIME`

🕑 Time of the run, HH:MM, local time

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `02:00`

#### `--resource RESOURCE`

☁️ Cloud to clean up every night (default: ccloud only)

🎓 Tip: repeat it, `--resource` ccloud `--resource` aws. Salesforce is  
not offered: nothing there is billed.

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Default Value:  | `ccloud`
| Allowed Values: | `ccloud`, `aws`, `gcp`, `azure`

## Examples

```bash
playground cloud-resources nightly-cleanup enable
```

```bash
playground cloud-resources nightly-cleanup enable --time 23:30
```

```bash
playground cloud-resources nightly-cleanup enable --resource ccloud --resource aws --resource azure
```


