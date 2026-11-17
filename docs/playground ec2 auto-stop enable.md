# playground ec2 auto-stop enable

⏰ Schedule the auto-stop, then show what tonight's run would stop

Run it again to change the time or the idle time. The job uses this  
checkout of the playground and the PATH of the shell you run it from.

## Usage

```bash
playground ec2 auto-stop enable [OPTIONS]
```

## Options

#### `--time TIME`

🕗 Time of the run, HH:MM, local time

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20:00`

#### `--idle-minutes MINUTES`

💤 Keep an instance whose CPU reached 5% in the last `<minutes>`, or started less than `<minutes>` ago (0: stop it whatever it is doing)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60`

## Examples

```bash
playground ec2 auto-stop enable
```

```bash
playground ec2 auto-stop enable --time 19:00 --idle-minutes 120
```


