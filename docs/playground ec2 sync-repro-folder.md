# playground ec2 sync-repro-folder

↔️ Synchronize reproduction-models folder between local and ec2 instance  
  
The reproduction models you write are the only thing on the instance  
worth keeping, and deleting the instance destroys them. These two  
commands copy that folder in one direction or the other with rsync.  
  
  local-to-ec2   push what you wrote locally, before running it there  
  ec2-to-local   pull back what you wrote there, before deleting it  
  
'playground ec2 create' runs local-to-ec2 for you, and  
'playground ec2 open --enable-sync-repro-folder' does it again each  
time you open the instance.  
  
⚠️ Get into the habit of running ec2-to-local before  
'playground ec2 delete', nothing else brings those files back.  
  
Note: rsync needs to be installed  


## Usage

```bash
playground ec2 sync-repro-folder COMMAND
```

## Dependencies

#### *rsync*

rsync needs to be installed

## == Commands ==

- [local-to-ec2](playground%20ec2%20sync-repro-folder%20local-to-ec2) - 👉 Sync local reproduction-models folder to ec2 instance
- [ec2-to-local](playground%20ec2%20sync-repro-folder%20ec2-to-local) - 👈 Sync ec2 instance reproduction-models folder to local


