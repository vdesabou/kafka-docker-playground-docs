# playground ec2

✨ Create and manage AWS EC2 instances (using Cloud Formation) to run kafka-docker-playground  
  
🪄 Open EC2 instances directly in Visual Studio code using Remote Development (over SSH)  
  
Run the playground on a remote machine instead of your laptop, which is  
what you want for an example that needs far more CPU or memory than you  
have, or one that must run for hours.  
  
  create              provision the instance with Cloud Formation  
  open                open it in VS Code over SSH, as if it were local  
  push-secrets        send your credentials to it, over ssh  
  sync-repro-folder   keep reproduction-models in step, both directions  
  list / status / start / stop / delete  
  
💰 The instance is billed while it runs. Use 'playground ec2 stop' when  
   you pause, and 'playground ec2 delete' when you are done;  
   'playground status' reminds you when one is still up.  
  
🔐 A pem file is created at the root of the repository when the instance  
   is created. Back it up, it is the only way in, and only your current  
   ip address is allowed to connect.

## Usage

```bash
playground ec2 COMMAND
```

## == Commands ==

- [create](playground%20ec2%20create) - 👷 Create kafka-docker-playground EC2 instance using AWS Cloud Formation
- [delete](playground%20ec2%20delete) - ❌ Delete an EC2 instance created with Cloud Formation
- [open](playground%20ec2%20open) - 👨‍💻 Open an EC2 instance using Visual Studio code
- [list](playground%20ec2%20list) - 🔘 List all EC2 instance
- [stop](playground%20ec2%20stop) - 🔴 Stop an EC2 instance
- [start](playground%20ec2%20start) - 🟢 Start an EC2 instance
- [sync-repro-folder](playground%20ec2%20sync-repro-folder) - ↔️ Synchronize reproduction-models folder between local and ec2 instance
- [push-secrets](playground%20ec2%20push-secrets) - 🔐 Send the secrets store to an ec2 instance


