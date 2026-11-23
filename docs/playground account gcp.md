# playground account gcp

☁️ Set up a Google Cloud project for the GCP examples, and check it

- **setup**: enable the APIs, create a service account with its roles and a key, store them
- **check**: verify that the stored key works, and that each API the examples use answers

Replaces the manual steps of the GCP example READMEs (service account,  
roles, keyfile.json copied in every example folder). Only creating the  
project, with billing enabled, stays manual.

📖 Step by step guide (project, billing, what each example needs, troubleshooting):  
https://kafka-docker-playground.io/#/gcp

## Usage

```bash
playground account gcp COMMAND
```

## Commands

- [check](playground%20account%20gcp%20check) - 🩺 Check that the stored GCP key works for the GCP examples
- [setup](playground%20account%20gcp%20setup) - 🛠️ Configure a Google Cloud project for the GCP examples


