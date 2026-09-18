# playground ec2 open

👨‍💻 Open an EC2 instance using Visual Studio code  
  
Opens a VS Code window on the instance over ssh, using Remote  
Development. The editor, the terminal and the playground CLI all run  
there, so it feels like working locally while the containers use the  
remote machine's CPU and memory.  
  
The security group is refreshed with your current ip on the way, so this  
is also the command to run after your ip changed and ssh stopped working.  
  
🔐 Only your current ip address will be allowed to connect.

## Usage

```bash
playground ec2 open [OPTIONS]
```

## Options

#### *--instance, -i INSTANCE*

🖥️ ec2 instance (need to use completion to get all required details)  
  
🎓 Tip: If not specified, the command will apply to all ec2 instances

#### *--enable-sync-repro-folder*

👉 Enable sync reproduction-models folder between local and ec2 instance


