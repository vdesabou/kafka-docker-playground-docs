# playground account servicenow

☁️ Set up the ServiceNow instance of the ServiceNow examples, and check it

- **setup**: validate and store the instance URL and the admin password, wake the instance up, fix basic authentication
- **check**: verify that the instance answers (awake, hibernating, released) and that admin can log in

The examples use a free Personal Developer Instance (PDI) and its admin  
user. A PDI hibernates when unused and is released after a few days  
without use: most failures are that. Only requesting the PDI on  
developer.servicenow.com stays manual.

📖 Step by step guide (PDI, hibernation, Identity Type, troubleshooting):  
https://kafka-docker-playground.io/#/servicenow

## Usage

```bash
playground account servicenow COMMAND
```

## Commands

- [check](playground%20account%20servicenow%20check) - 🩺 Check the ServiceNow instance of the ServiceNow examples
- [setup](playground%20account%20servicenow%20setup) - 🛠️ Validate and store the ServiceNow instance of the ServiceNow examples


