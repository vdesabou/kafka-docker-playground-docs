# playground tools cert inspect

🔍 Inspect certificates and explain what breaks TLS

Reads a keystore or truststore (JKS, PKCS12), a PEM or DER certificate  
(a chain, a private key), and / or the chain a server sends  
(`--server` host:port), and checks what makes Kafka clients fail:

expired (or not yet valid) certificates, and the ones expiring soon  
the order and the end of each chain (a missing intermediate)  
`--hostname` in the subject alternative names (No subject alternative names matching)  
`--truststore` trusts the chain (PKIX path building failed)  
the private key belongs to the certificate (in the PEM, or `--key`)  
`--purpose` server|client in the extended key usage, CA used as leaf,  
RSA keys under 2048 bits, SHA-1 signatures

It prints a digest and writes an HTML report made for someone new to  
TLS: every problem with what it means, why it matters, the java error it  
causes and how to fix it, each chain drawn certificate by certificate,  
and a glossary. Exit code 1 when a problem is found.

keytool and openssl run in the connect image: nothing to install. A  
keystore opens with `--password`, or else with an empty, 'confluent' or  
'changeit' password (the report says which one).

🎓 Tip: for a customer error 'PKIX path building failed', run it on their  
server certificate (or `--server`) with `--truststore` `<their truststore>`.

## Usage

```bash
playground tools cert inspect [OPTIONS]
```

## Options

#### `--file, -f FILE`

📄 Keystore, truststore (.jks, .p12, .pfx), PEM (.pem, .crt, .cer: certificates, private key) or DER certificate

#### `--password PASSWORD`

🔑 Password of the keystore of `--file` (or of the encrypted private key)

#### `--key KEY`

🗝️ Private key (PEM) to check against the first certificate

#### `--truststore TRUSTSTORE`

📒 Truststore (JKS, PKCS12 or PEM bundle) that should trust the chain(s)

#### `--truststore-password TRUSTSTORE_PASSWORD`

🔑 Password of `--truststore`

#### `--server SERVER`

🖥️ `<host>:<port>` of a TLS server whose chain to inspect (a playground container such as broker:9093, or any reachable server)

#### `--servername SERVERNAME`

🏷️ SNI sent to `--server` (default: its host)

#### `--hostname HOSTNAME`

🏷️ Hostname the clients use to connect: checked against the subject alternative names (default: the host of `--server`)

#### `--purpose PURPOSE`

🎯 Role of the certificate, checked against its extended key usage: server (broker, schema registry...) or client (mTLS)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `server`, `client`

#### `--output-dir OUTPUT_DIR`

📂 Output directory of the HTML report (default: /tmp/playground-cert-inspect)

#### `--no-open`

🚫 Do not open the HTML report in the browser

#### `--json`

🤖 Print the result as JSON (no HTML report)

#### `--verbose, -v`

🐞 Show command being ran.

## Examples

```bash
playground tools cert inspect --file keystore.jks --password confluent
```

```bash
playground tools cert inspect --file broker.pem --truststore client-truststore.jks --hostname broker.example.com
```

```bash
playground tools cert inspect --server broker:9093 --truststore ./security/kafka.client.truststore.jks
```

```bash
playground tools cert inspect --file client.crt --key client.key --purpose client
```

```bash
playground tools cert inspect --file keystore.p12 --password secret --json | jq -r '.entries[].checks[] | select(.status == "fail") | .check'
```

## Example output

```text
$ playground tools cert inspect --file expired-chain.pem --truststore wrong-truststore.jks --truststore-password confluent --hostname kafka.example.com
15:18:17 ℹ️ truststore wrong-truststore.jks: 1 certificate(s)
15:18:17 ℹ️ 🔐 expired-chain.pem (pem)
   #1 CN=expired
      issuer   CN=Test Intermediate CA
      valid    2020-01-01 → 2021-01-01 (expired 2133 days ago)
      SAN      DNS:broker,DNS:localhost
      key      RSA 2048 bits, sha256WithRSAEncryption
      usage    Digital Signature, Key Encipherment | TLS Web Server Authentication, TLS Web Client Authentication
      sha256   A8:B7:BF:75:52:4E:81:EA:62:B1:CD:2F:EF:6D:5B:52:DF:25:A6:0D:51:BB:FC:33:2B:EC:52:45:7B:36:88:81
   #2 CN=Test Intermediate CA
      issuer   CN=Test Root CA
      valid    2026-11-04 → 2031-11-03 (1824 days left)
      key      RSA 2048 bits, sha256WithRSAEncryption, CA
      usage    Certificate Sign, CRL Sign
      sha256   75:D7:C9:EE:35:ED:B9:D5:3B:15:25:2D:A6:60:71:7B:26:E3:D4:C1:56:4A:7C:70:3B:67:2F:EB:0D:90:46:02
   ❌ expiry of #1 (expired)           expired on 2021-01-01
      👉 renew the certificate ('playground tools cert create' for the playground ones)
   ✅ chain order                      2 certificates, each one issued by the next one
   ℹ️  chain end                        ends at a certificate issued by CN=Test Root CA, not included: the truststore of the peers must contain it
   ❌ hostname kafka.example.com       not in the SANs (DNS:broker,DNS:localhost)
      👉 java fails with 'No subject alternative names matching ... found': regenerate with -ext SAN=dns:kafka.example.com, or set ssl.endpoint.identification.algorithm= (empty) on the client to skip the check
   ❌ truststore wrong-truststore.jks  does not trust the chain: the truststore does not have the CA that issued the last certificate of the chain (CN=Test Root CA)
      👉 java fails with 'PKIX path building failed: unable to find valid certification path to requested target': import the root (or the intermediate) CA of the chain into the truststore
15:18:17 ℹ️ ✅ HTML report saved: /tmp/playground-cert-inspect/cert-inspect-expired-chain.pem-20261104-151817.html
15:18:17 🔥 ❌ 3 problem(s), ⚠️ 0 warning(s), ✅ 1 ok
```


