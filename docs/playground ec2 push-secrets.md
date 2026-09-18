# playground ec2 push-secrets

🔐 Send the secrets store to an ec2 instance  
  
Writes ~/.playground-secrets.properties (mode 0600) on the instance, which  
the playground .zshrc sources on login. This replaces the encrypted  
secrets.tar.gpg committed in the repository.  
  
The file is piped over ssh, so no clear text copy is ever written locally  
and the values never appear in 'ps'.  
  
The credentials that cannot be stored as name=value pairs are sent too,  
when they exist at the root of the repository:  
  
  aws_credentials_with_assuming_iam_role       -\> ~/.aws/credentials-with-assuming-iam-role  
  aws_credentials_aws_account_with_assume_role -\> ~/.aws/credentials_aws_account_with_assume_role  
  github_ssh_key_file                          -\> ~/.ssh/id_rsa

## Usage

```bash
playground ec2 push-secrets [OPTIONS]
```

## Options

#### *--instance, -i INSTANCE*

🖥️ ec2 instance (need to use completion to get all required details)  
  
🎓 Tip: If not specified, the command will apply to all ec2 instances

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

#### *--dry-run*

🔍 List what would be sent, change nothing

## Examples

```bash
playground ec2 push-secrets
```

```bash
playground ec2 push-secrets --instance pg-vsaboulin-abc123
```


