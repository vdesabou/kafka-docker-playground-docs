# playground forgotten-environment run

🔔 Check now whether a local environment runs with nobody using it, as the scheduled job does

Prints what runs, from which checkout, since when, and the last playground  
activity. Never stops anything.

## Usage

```bash
playground forgotten-environment run [OPTIONS]
```

## Options

#### `--idle-hours HOURS`

⏳ Notify only when no container started and no playground command ran for this number of hours

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `3`

## Examples

```bash
playground forgotten-environment run
```

```bash
playground forgotten-environment run --idle-hours 1
```


