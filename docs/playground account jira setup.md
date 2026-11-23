# playground account jira setup

🛠️ Validate and store the Jira account of the Jira examples (connect-jira-source, fm-jira-source)

Takes `JIRA_URL`, `JIRA_USERNAME` and `JIRA_API_TOKEN` from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (the login (myself) and the projects the sources read), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account jira setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account jira setup
```


