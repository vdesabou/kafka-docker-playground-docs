# playground schema exporter

🔗 Schema Linking: exporters that copy subjects to another registry

An exporter runs in the source registry and copies the subjects it  
matches (with their ids) to the destination, continuously. With context  
type AUTO they land in the context .`<exporter name>`, with CUSTOM in  
`--destination-context`, with NONE in the default context.

In an mdc-\* environment, `--cluster` is the source and `--to` the  
destination (the other cluster by default). Elsewhere, set  
`--destination-url` (and `--destination-auth`).

⚠️ The source registry needs the exporter extension (resource.extension  
.class, kafkastore.update.handlers, password.encoder.secret): the  
commands say what to add when it is missing, and  
other/deep-dive-labs/docker-compose.mdc-plaintext.replication.yml  
enables it on both registries of mdc-plaintext.

See https://docs.confluent.io/platform/current/schema-registry/schema-linking-cp.html

## Usage

```bash
playground schema exporter COMMAND
```

## Commands

- [create](playground%20schema%20exporter%20create) - 🔗 Create an exporter, then wait until it runs
- [list](playground%20schema%20exporter%20list) - 📋 List the exporters of the registry, with their state
- [status](playground%20schema%20exporter%20status) - 🚦 State of an exporter (RUNNING, PAUSED, ERROR with its trace), offset and number of objects exported
- [pause](playground%20schema%20exporter%20pause) - ⏸️ Pause an exporter
- [resume](playground%20schema%20exporter%20resume) - ▶️ Resume a paused exporter
- [reset](playground%20schema%20exporter%20reset) - ⏮️ Reset a paused exporter: it exports everything again
- [delete](playground%20schema%20exporter%20delete) - 🗑️ Delete a paused exporter (the exported schemas stay in the destination)


