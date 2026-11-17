# playground ec2

✨ Create and manage AWS EC2 instances (using Cloud Formation) to run kafka-docker-playground

🪄 Open EC2 instances directly in Visual Studio code using Remote Development (over SSH)

Run the playground on a remote machine instead of your laptop, which is  
what you want for an example that needs far more CPU or memory than you  
have, or one that must run for hours.

- **create**: provision the instance with Cloud Formation
- **open**: open it in VS Code over SSH, as if it were local
- **push-secrets**: send your credentials to it, over ssh
- **sync-repro-folder**: keep reproduction-models in step, both directions
- **list / status / start / stop / delete**
- **auto-stop**: stop the instances left running, every evening

💰 The instance is billed while it runs. Use `playground ec2 stop` when  
you pause, and `playground ec2 delete` when you are done;  
`playground status` reminds you when one is still up, and  
`playground ec2 auto-stop enable` stops them every evening if idle.

🔐 A pem file is created at the root of the repository when the instance  
is created. Back it up, it is the only way in, and only your current  
ip address is allowed to connect.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-ec2

## Usage

```bash
playground ec2 COMMAND
```

## Commands

- [create](playground%20ec2%20create) - 👷 Create kafka-docker-playground EC2 instance using AWS Cloud Formation
- [delete](playground%20ec2%20delete) - ❌ Delete an EC2 instance created with Cloud Formation
- [open](playground%20ec2%20open) - 👨‍💻 Open an EC2 instance using Visual Studio code
- [list](playground%20ec2%20list) - 🔘 List all EC2 instance
- [stop](playground%20ec2%20stop) - 🔴 Stop an EC2 instance
- [auto-stop](playground%20ec2%20auto-stop) - ⏰ Stop your EC2 instances left running, every evening, automatically
  - [enable](playground%20ec2%20auto-stop%20enable) - ⏰ Schedule the auto-stop, then show what tonight's run would stop
  - [disable](playground%20ec2%20auto-stop%20disable) - 🛑 Remove the auto-stop schedule
  - [status](playground%20ec2%20auto-stop%20status) - 🔎 Is the auto-stop scheduled, at what time, and what did its last runs do
  - [run](playground%20ec2%20auto-stop%20run) - ⏰ Stop now your idle EC2 instances still running, as the scheduled job does
- [start](playground%20ec2%20start) - 🟢 Start an EC2 instance
- [sync-repro-folder](playground%20ec2%20sync-repro-folder) - ↔️ Synchronize reproduction-models folder between local and ec2 instance
  - [local-to-ec2](playground%20ec2%20sync-repro-folder%20local-to-ec2) - 👉 Sync local reproduction-models folder to ec2 instance
  - [ec2-to-local](playground%20ec2%20sync-repro-folder%20ec2-to-local) - 👈 Sync ec2 instance reproduction-models folder to local
- [push-secrets](playground%20ec2%20push-secrets) - 🔐 Send the secrets store to an ec2 instance


