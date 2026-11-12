# playground cloud-resources nightly-cleanup enable

🌙 Schedule the nightly cleanup, then show what tonight's run would delete

Run it again to change the time. The job uses this checkout of the  
playground and the PATH of the shell you run it from.

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

## Examples

```bash
playground cloud-resources nightly-cleanup enable
```

```bash
playground cloud-resources nightly-cleanup enable --time 23:30
```


