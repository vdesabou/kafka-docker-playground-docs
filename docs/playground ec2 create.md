# playground ec2 create

👷 Create kafka-docker-playground EC2 instance using AWS Cloud Formation

## Usage

```bash
playground ec2 create [OPTIONS]
```

## Environment Variables

#### *EC2_CLOUD_FORMATION_PEM_FILE*

🔐 AWS EC2 pem file

#### *EC2_CLOUD_FORMATION_YML_FILE*

🌀 Cloud Formation yml file

## Options

#### *--pem-file PEM-FILE*

🔐 AWS EC2 pem file  
  
❕ It must be absolute full path  
  
You can also specify it with EC2_CLOUD_FORMATION_PEM_FILE environment variable  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--cloud-formation-yml-file CLOUD-FORMATION-YML-FILE*

🌀 Cloud Formation yml file  
  
❕ It must be absolute full path  
  
If not set default is used https://github.com/vdesabou/kafka-docker-playground/blob/master/cloudformation/kafka-docker-playground.yml  
  
You can also specify it with EC2_CLOUD_FORMATION_YML_FILE environment variable  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--instance-type INSTANCE-TYPE*

🧑‍💻 instance type. default is t3.2xlarge

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | t3.2xlarge
| Allowed Values: | c1.medium, c1.xlarge, c3.2xlarge, c3.4xlarge, c3.8xlarge, c3.large, c3.xlarge, c4.2xlarge, c4.4xlarge, c4.large, c4.xlarge, m1.large, m1.medium, m1.small, m1.xlarge, m2.2xlarge, m2.4xlarge, m2.xlarge, m3.2xlarge, m3.large, m3.medium, m3.xlarge, m4.10xlarge, m4.2xlarge, m4.4xlarge, m4.large, m4.xlarge, t1.micro, t2.large, t2.medium, t2.micro, t2.nano, t2.small, t3.2xlarge

#### *--region REGION*

🌍 instance region. default is eu-west-3

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | eu-west-3
| Allowed Values: | ap-northeast-1, ap-northeast-2, ap-northeast-3, ap-south-1, ap-southeast-1, ap-southeast-2, ca-central-1, cn-north-1, cn-northwest-1, eu-central-1, eu-north-1, eu-west-1, eu-west-2, eu-west-3, sa-east-1, us-east-1, us-east-2, us-west-1, us-west-2

#### *--size SIZE*

💾 instance size in Gb. default is 1000 Gb

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 1000

#### *--suffix SUFFIX*

📮 suffix to add to instance name kafka-docker-playground-${username}-${suffix}   
  
If not set, default is kafka-docker-playground-${username}-${current-date}

