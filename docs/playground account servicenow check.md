# playground account servicenow check

🩺 Check the ServiceNow instance of the ServiceNow examples

Calls the REST API like the examples (basic authentication as admin on  
`SERVICENOW_URL`) and tells apart: awake and logged in, wrong password or  
Identity Type not Machine (401), hibernating, waking up, released or  
wrong URL. Then checks the tables the examples use, and whether they can  
wake the instance up by themselves (SERVICENOW_DEVELOPER_\*).

Read-only, needs neither Docker nor a browser, takes a few seconds.

Exits with 1 when the instance does not answer with admin logged in.

## Usage

```bash
playground account servicenow check
```

## Examples

```bash
playground account servicenow check
```


