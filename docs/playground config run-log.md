# playground config run-log

📄 write a masked log of each `playground run` (default true)

The output of the run is also written to a text file, with the  
passwords, api keys and tokens masked, to share it with a colleague or  
engineering. Its path is printed at the end of the run.

The masking is best-effort: review the file before sharing it outside  
Confluent.

## Usage

```bash
playground config run-log [ENABLED]
```

## Arguments

#### `ENABLED`



| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `true`
| Allowed Values: | `true`, `false`

## Examples

```bash
playground config run-log false
```

```bash
playground config run-log true
```


