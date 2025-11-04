# playground connector enable-remote-debugging

✨ Enable java remote debugging for the connector.  
  
👉 Check documentation https://kafka-docker-playground.io/#/reusables?id=%e2%9c%a8-remote-debugging  
  
🏗️ It will checkout (you need git installed) and compile code for the connector (required for remote debugging).  
  
💌 Confluent employees only: make sure to follow "Maven FAQ", you also need to be on Confluent VPN with proper AWS credentials set in order to be able to download proprietary dependencies.  
  
⚠️ This does not work for fully and custom connectors.

## Usage

```bash
playground connector enable-remote-debugging
```

## Dependencies

#### *git*

visit https://docs.confluent.io/confluent-cli/current/overview.html to install


