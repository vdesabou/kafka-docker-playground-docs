# playground debug testssl

🔐 Testing TLS/SSL encryption using https://testssl.sh/  
  
testssl \<URI\>, where \<URI\> is:  
  
host|host:port|URL|URL:port   port 443 is default, URL can only contain HTTPS protocol

## Usage

```bash
playground debug testssl [ARGUMENTS]
```

## Examples

```bash
playground debug testssl https://google.com
```

```bash
playground debug testssl pkc-xxxx.us-west-2.aws.confluent.cloud:9092
```

## Arguments

#### *ARGUMENTS*

arguments to pass to testssl, see https://testssl.sh for all options


