# playground ec2 auto-stop run

⏰ Stop now your idle EC2 instances still running, as the scheduled job does

Use `--dry-run` to see what tonight's run would stop.

## Usage

```bash
playground ec2 auto-stop run [OPTIONS]
```

## Options

#### `--idle-minutes MINUTES`

💤 Keep an instance whose CPU reached 5% in the last `<minutes>`, or started less than `<minutes>` ago (0: stop it whatever it is doing)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60`

#### `--dry-run`

🔎 Only show which instances would be stopped, and why the others are kept

## Examples

```bash
playground ec2 auto-stop run --dry-run
```

```bash
playground ec2 auto-stop run --idle-minutes 0
```


