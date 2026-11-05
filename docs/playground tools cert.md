# playground tools cert

🔐 Certificate commands

- **create**: a CA, then a keystore and a truststore per container
- **inspect**: why TLS fails: keystore, truststore, certificate or server chain, explained in an HTML report for TLS beginners
- **convert**: JKS, PKCS12, PEM, DER, or Kafka properties with PEM inline

🎓 Tip: for a customer error 'PKIX path building failed' or 'No subject  
alternative names matching', run 'inspect' on their certificate with their  
truststore and the hostname the clients use.

## Usage

```bash
playground tools cert COMMAND
```

## Commands

- [create](playground%20tools%20cert%20create) - 🔐 Generate keys and certificates used for SSL
- [inspect](playground%20tools%20cert%20inspect) - 🔍 Inspect certificates and explain what breaks TLS
- [convert](playground%20tools%20cert%20convert) - 🔄 Convert certificates and keystores between formats


