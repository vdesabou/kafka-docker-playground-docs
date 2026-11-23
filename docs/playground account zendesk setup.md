# playground account zendesk setup

🛠️ Validate and store the Zendesk account of the Zendesk examples (connect-zendesk-source, fm-zendesk-source)

Takes `ZENDESK_URL`, `ZENDESK_USERNAME` and `ZENDESK_PASSWORD` from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (the login (users/me, the `<email>`/token form) and the tickets the sources read), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account zendesk setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account zendesk setup
```


