# playground ec2 open

👨‍💻 Open an EC2 instance using Visual Studio code  
  
🔐 Only your current ip address will be allowed to connect

## Usage

```bash
playground ec2 open [OPTIONS]
```

## Environment Variables

#### *EC2_CLOUD_FORMATION_PEM_FILE*

🔐 AWS EC2 pem file

## Options

#### *--pem-file PEM-FILE*

🔐 AWS EC2 pem file  
  
❕ It must be absolute full path  
  
You can also specify it with EC2_CLOUD_FORMATION_PEM_FILE environment variable  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--instance, -i INSTANCE*

🖥️ EC2 instance (need to use completion to get all required details)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes


