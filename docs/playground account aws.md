# playground account aws

☁️ Set up the AWS credentials of the AWS examples, and check them

- **setup**: validate and store the access keys and the region; optionally the IAM role of the assume-role variants
- **check**: verify the keys, the region, each service the examples use, and the assume-role setup

Every AWS example creates its own resources (bucket, stream, queue,  
table...) and deletes them: what they need is access keys allowed to do  
it, a region, and, for the assume-role variants, an IAM role.

📖 Step by step guide (keys, region, assume role, troubleshooting):  
https://kafka-docker-playground.io/#/aws

## Usage

```bash
playground account aws COMMAND
```

## Commands

- [check](playground%20account%20aws%20check) - 🩺 Check the AWS credentials of the AWS examples
- [setup](playground%20account%20aws%20setup) - 🛠️ Validate and store the AWS credentials of the AWS examples


