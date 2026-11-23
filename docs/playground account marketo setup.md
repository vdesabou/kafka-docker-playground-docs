# playground account marketo setup

🛠️ Validate and store the Marketo account of the Marketo examples (connect-marketo-source, fm-marketo-sink)

Takes `MARKETO_ENDPOINT_URL`, `MARKETO_CLIENT_ID` and `MARKETO_CLIENT_SECRET` from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (the OAuth token of the LaunchPoint service and the leads API (603: missing API role)), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account marketo setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account marketo setup
```


