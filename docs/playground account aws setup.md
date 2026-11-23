# playground account aws setup

🛠️ Validate and store the AWS credentials of the AWS examples

Takes the access keys from `--profile` (a profile of your aws CLI), else  
the environment, else the first key pair of ~/.aws/credentials (what  
the examples use), and the region from `--region`, else your aws CLI.  
Refuses temporary credentials (session token): fully managed  
connectors can't use them. Validates the keys (sts  
get-caller-identity), stores `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`  
and `AWS_REGION` with `playground secrets set`, then runs check.

With `--assume-role`, also creates the IAM role of the assume-role  
variants (pg-assume-role-`<user>`, trusted by the principal of  
`--assume-role-profile` with the external id 123 the examples use, allowed  
on S3, Kinesis, SQS, DynamoDB, Lambda, CloudWatch), and stores  
`AWS_STS_ROLE_ARN` and `AWS_ACCOUNT_WITH_ASSUME_ROLE_AWS_ACCESS_KEY_ID` /  
_SECRET_ACCESS_KEY. `--dry-run` prints the policies.

## Usage

```bash
playground account aws setup [OPTIONS]
```

## Options

#### `--profile PROFILE`

👤 Profile of your aws CLI to take the keys (and the region) from

#### `--region REGION`

🌍 Region of the examples (a region Confluent Cloud supports, for the fully managed ones)

#### `--assume-role`

🎭 Also create the IAM role of the assume-role variants

#### `--assume-role-profile ASSUME_ROLE_PROFILE`

👥 Profile of the second account (the principal that assumes the role)

Default: the stored `AWS_ACCOUNT_WITH_ASSUME_ROLE_AWS_ACCESS_KEY_ID` /  
_SECRET_ACCESS_KEY.

#### `--dry-run`

🧪 Only print what would be stored and the IAM policies, change nothing

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account aws setup
```

```bash
playground account aws setup --profile my-sandbox --region eu-west-3
```

```bash
playground account aws setup --assume-role --assume-role-profile my-second-account --dry-run
```


