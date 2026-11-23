# playground account aws check

🩺 Check the AWS credentials of the AWS examples

Resolves the keys like the examples (environment or secrets store, then  
~/.aws/credentials), tells temporary credentials apart (fully managed  
connectors refuse them), validates them (sts get-caller-identity) and the  
region, then calls each service the examples use (S3, Kinesis, SQS,  
DynamoDB, Lambda and IAM roles, CloudWatch Logs and Metrics, Redshift,  
Athena), checks the bucket name of your examples, and, when  
`AWS_STS_ROLE_ARN` is set, assumes the role like the assume-role variants  
do. Each failure says why and which examples it breaks.

Read-only. Uses your aws CLI, else the amazon/aws-cli image.

Exits with 1 when the keys don't work.

## Usage

```bash
playground account aws check
```

## Examples

```bash
playground account aws check
```


