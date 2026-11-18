# playground forgotten-environment enable

🔔 Schedule the evening check of a forgotten local environment, then run it once now

Run it again to change the time or `--idle-hours`. The job uses this checkout  
of the playground and the PATH of the shell you run it from.

## Usage

```bash
playground forgotten-environment enable [OPTIONS]
```

## Options

#### `--time TIME`

🕖 Time of the check, HH:MM, local time

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `19:00`

#### `--idle-hours HOURS`

⏳ Notify only when no container started and no playground command ran for this number of hours

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3`

## Examples

```bash
playground forgotten-environment enable
```

```bash
playground forgotten-environment enable --time 21:30 --idle-hours 5
```


