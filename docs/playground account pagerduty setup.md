# playground account pagerduty setup

🛠️ Validate and store the PagerDuty account of the PagerDuty example (connect-pagerduty-sink)

Takes `PAGERDUTY_API_KEY`, `PAGERDUTY_SERVICE_ID` and `PAGERDUTY_USER_EMAIL` from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (the service the incidents go to, and the user that sends them), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account pagerduty setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account pagerduty setup
```


