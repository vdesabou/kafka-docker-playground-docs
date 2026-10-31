# playground debug testssl

🔐 Testing TLS/SSL encryption using https://testssl.sh/

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-java-debugging

## Usage

```bash
playground debug testssl [OPTIONS] [--] [TESTSSL ARGUMENTS...]
```

## Options

#### `--uri URI`

host|host:port|URL|URL:port   port 443 is default, URL can only contain HTTPS protocol

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Examples

```bash
playground debug testssl --uri "https://google.com" --fast
```

```bash
playground debug testssl --uri "pkc-xxxx.us-west-2.aws.confluent.cloud:9092"
```


