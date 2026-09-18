# playground ec2 delete

❌ Delete an EC2 instance created with Cloud Formation  
  
Deletes the Cloud Formation stack, which takes the instance, its volume  
and its security group with it, then removes the key pair on AWS and the  
local pem file. This is what stops the billing for good, unlike stop  
which only pauses it.  
  
⚠️ Everything on the instance is lost, including any reproduction model  
you have not synced back with 'playground ec2 sync-repro-folder'.  
  
Without --instance it applies to all your instances, and asks you to  
confirm first.

## Usage

```bash
playground ec2 delete [OPTIONS]
```

## Options

#### *--instance, -i INSTANCE*

🌀 ec2 instance cloudformation (need to use completion to get all required details)  
  
🎓 Tip: If not specified, the command will apply to all ec2 instances


