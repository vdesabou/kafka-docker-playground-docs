# playground tools

🧰 Tools commands

Small utilities that are handy around the playground but are not tied to a  
running environment:

- **read-avro-file**: dump an avro file as readable json
- **read-parquet-file**: same, for parquet
- **cert create**: generate a keystore and truststore for a component
- **cert inspect**: why TLS fails: keystores, certificates, server chains
- **cert convert**: JKS, PKCS12, PEM, DER, Kafka properties with PEM inline
- **redos-check**: check a topics.regex for catastrophic backtracking
- **http-server**: drive the http test server of the http examples: set-response, reset, requests
- **install-vscode-extension**: playground completion inside VS Code
- **install-alfred-workflow**: kdp launcher for the playground CLI (macOS)

🎓 Tip: the file readers are what you use to check what a sink connector  
really wrote, after pulling the file out with `playground container cp`.

## Usage

```bash
playground tools COMMAND
```

## Commands

- [install-vscode-extension](playground%20tools%20install-vscode-extension) - 🪄 Install a slightly modified version of "Shell Script Command Completion" Visual Studio Code extension (https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)
- [install-alfred-workflow](playground%20tools%20install-alfred-workflow) - 🎩 Install the "kafka-docker-playground (kdp)" Alfred workflow (macOS, Alfred 5 with the Powerpack)
- [read-avro-file](playground%20tools%20read-avro-file) - 🔖 Read provided avro file
- [read-parquet-file](playground%20tools%20read-parquet-file) - 🔖 Read provided parquet file
- [cert](playground%20tools%20cert) - 🔐 Certificate commands
  - [create](playground%20tools%20cert%20create) - 🔐 Generate keys and certificates used for SSL
  - [inspect](playground%20tools%20cert%20inspect) - 🔍 Inspect certificates and explain what breaks TLS
  - [convert](playground%20tools%20cert%20convert) - 🔄 Convert certificates and keystores between formats
- [redos-check](playground%20tools%20redos-check) - 🪖 Check topics.regex for ReDos vulnerabilities using recheck (https://github.com/makenowjust-labs/recheck)

## Tools commands

- [http-server](playground%20tools%20http-server) - 🌐 Drive the http test server of the http examples
  - [set-response](playground%20tools%20http-server%20set-response) - 🎛️ Set how the http test server answers
  - [reset](playground%20tools%20http-server%20reset) - 🔄 Reset the http test server
  - [requests](playground%20tools%20http-server%20requests) - 📥 Show the requests received by the http test server


