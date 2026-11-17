# playground docker-cleanup enable

🧽 Schedule the weekly cleanup, then show what it would remove now

Run it again to change the day, the time or the limits. The job uses this  
checkout of the playground and the PATH of the shell you run it from.

## Usage

```bash
playground docker-cleanup enable [OPTIONS]
```

## Options

#### `--day DAY`

📅 Day of the week of the run

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `sunday`
| Allowed Values: | `sunday`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`

#### `--time TIME`

🕙 Time of the run, HH:MM, local time

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10:00`

#### `--older-than DAYS`

📆 Remove the Confluent Platform versions not used for this number of days

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60`

#### `--max-build-cache GB`

🧱 Build cache to keep, in GB: above it, the least recently used build cache is removed

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `10`

## Examples

```bash
playground docker-cleanup enable
```

```bash
playground docker-cleanup enable --day friday --time 18:00 --older-than 30 --max-build-cache 20
```


