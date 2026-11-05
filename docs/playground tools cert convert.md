# playground tools cert convert

🔄 Convert certificates and keystores between formats

`--to` pkcs12 | jks   a keystore (JKS / PKCS12) in the other format; PEM  
with a private key (in the file or `--key`): a  
keystore with the key and its chain; PEM or DER  
certificates only: a truststore  
`--to` pem            from a keystore, per key pair entry  
`<name>`-`<alias>`.certificate.pem (chain) and  
`<name>`-`<alias>`.key.pem (PKCS#8), the trusted  
certificates in `<name>`.truststore.pem: the files of  
librdkafka (python, go, .net) clients  
`--to` der            the first certificate (of each key pair entry)  
`--to` properties     Kafka client properties with the certificates  
inline (ssl.keystore.type=PEM,  
ssl.keystore.certificate.chain, ssl.keystore.key,  
ssl.truststore.certificates): no file to copy  
(Apache Kafka 2.7+, CP 6.1+)

The files are written next to `--file` (`--output-folder` to change it),  
never over an existing file unless `--force`. A keystore opens with  
`--password`, or else an empty, 'confluent' or 'changeit' password; the  
outputs use `--output-password` (default: the input password, or  
'confluent').

🎓 Tip: check the result with `playground tools cert inspect`.

## Usage

```bash
playground tools cert convert [OPTIONS]
```

## Options

#### `--file, -f FILE`

📄 Keystore or truststore (.jks, .p12, .pfx), PEM (certificates, private key) or DER certificate to convert

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--to TO`

🎯 Output format

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes
| Allowed Values: | `pkcs12`, `jks`, `pem`, `der`, `properties`

#### `--key KEY`

🗝️ Private key (PEM) of the first certificate of `--file`, for a keystore from PEM

#### `--password PASSWORD`

🔑 Password of `--file` (keystore), or of the encrypted private key

#### `--output-password OUTPUT_PASSWORD`

🔑 Password of the output keystore, or of the output private key (`--to` pem: encrypted only when set)

#### `--alias ALIAS`

🏷️ Only this entry of the keystore, or the name of the entry created from PEM (default: the CN of the certificate)

#### `--output-folder OUTPUT_FOLDER`

📁 Folder of the output files (default: the folder of `--file`)

#### `--force`

💪 Replace the output files when they exist

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground tools cert convert --file kafka.client.keystore.jks --password confluent --to pkcs12
```

```bash
playground tools cert convert --file kafka.client.keystore.jks --password confluent --to pem
```

```bash
playground tools cert convert --file client.crt --key client.key --to pkcs12 --output-password secret123
```

```bash
playground tools cert convert --file ca-bundle.pem --to jks --output-password changeit
```

```bash
playground tools cert convert --file kafka.client.truststore.jks --password confluent --to properties
```

## Example output

```text
$ playground tools cert convert --file kafka.client.keystore.jks --to pem
15:17:49 ℹ️ 🔄 Converting kafka.client.keystore.jks to pem
15:17:54 ℹ️ kafka.client.keystore.jks: opened with the password 'confluent' (no --password)
15:17:54 ℹ️ kafka.client.keystore.jks: keystore type PKCS12
15:17:54 ℹ️ ✅ /tmp/certs/kafka.client.keystore-client.certificate.pem
   certificate chain of 'client' (2 certificate(s), the first one is its own): librdkafka ssl.certificate.location
15:17:54 ℹ️ ✅ /tmp/certs/kafka.client.keystore-client.key.pem
   private key of 'client' (PKCS#8, not encrypted: keep it private): librdkafka ssl.key.location
15:17:54 ℹ️ ✅ /tmp/certs/kafka.client.keystore.truststore.pem
   1 trusted certificate(s) (CA bundle): librdkafka ssl.ca.location
15:17:54 ℹ️ 🎓 librdkafka clients (python, go, .net, C): ssl.ca.location, ssl.certificate.location, ssl.key.location
15:17:54 ℹ️ 🔍 check the result: playground tools cert inspect --file /tmp/certs/kafka.client.keystore-client.certificate.pem
```

```text
$ playground tools cert convert --file kafka.client.keystore.jks --to properties
15:18:01 ℹ️ 🔄 Converting kafka.client.keystore.jks to properties
15:18:02 ℹ️ kafka.client.keystore.jks: opened with the password 'confluent' (no --password)
15:18:02 ℹ️ kafka.client.keystore.jks: keystore type PKCS12
15:18:02 ℹ️ ✅ /tmp/certs/kafka.client.keystore.properties
   Kafka client properties with PEM inline: ssl.keystore.* (key + 2 certificate(s)), ssl.truststore.* (1 trusted certificate(s))
15:18:02 ℹ️ 🎓 add these lines to the client properties (security.protocol=SSL or SASL_SSL): the certificates are inline, no file to copy
```


