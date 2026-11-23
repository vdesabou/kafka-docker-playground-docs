# playground account servicenow setup

🛠️ Validate and store the ServiceNow instance of the ServiceNow examples

Normalizes the URL (dev12345, dev12345.service-now.com or the full URL  
become https://dev12345.service-now.com/, with the trailing / the  
examples need), wakes the instance up if it hibernates (with your  
ServiceNow ID, like the examples), makes basic authentication work for  
admin (Identity Type = Machine, like the examples), then stores  
`SERVICENOW_URL`, `SERVICENOW_PASSWORD` and, when given,  
`SERVICENOW_DEVELOPER_USERNAME` / `SERVICENOW_DEVELOPER_PASSWORD` with  
`playground secrets set`, and runs check.

Missing values are taken from the stored ones, else asked for (the  
passwords without echo).

## Usage

```bash
playground account servicenow setup [OPTIONS]
```

## Options

#### `--url URL`

🌐 Instance: dev12345, dev12345.service-now.com or https://dev12345.service-now.com/

#### `--password PASSWORD`

🔐 Password of user admin of the instance (asked for without echo when missing)

#### `--developer-username DEVELOPER_USERNAME`

👤 Your ServiceNow ID (developer.servicenow.com login): lets the examples wake the instance up

#### `--developer-password DEVELOPER_PASSWORD`

🔐 Password of your ServiceNow ID

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account servicenow setup --url dev12345
```

```bash
playground account servicenow setup --developer-username me@example.com
```


