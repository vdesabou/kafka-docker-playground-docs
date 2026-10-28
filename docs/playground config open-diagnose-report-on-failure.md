# playground config open-diagnose-report-on-failure

🩺 open the HTML report when a connector fails (default true)

When 'connector create-or-update' or 'connector wait' find a FAILED  
connector or task, they run `playground connector diagnose` on it. Its  
HTML report is opened in the browser from an interactive terminal (never  
in CI). Set it to false to only print the path of the report.

## Usage

```bash
playground config open-diagnose-report-on-failure [ENABLED]
```

## Arguments

#### `ENABLED`



| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `true`
| Allowed Values: | `true`, `false`

## Examples

```bash
playground config open-diagnose-report-on-failure false
```

```bash
playground config open-diagnose-report-on-failure true
```


