# playground schema

🔰 Schema commands

Talk to the Schema Registry of the running environment, whether it is the  
local container or the one in Confluent Cloud, without building the urls  
and the credentials yourself.

**🔍 Read**

- **list**: every subject: versions, latest id, type, rule, mode
- **describe**: everything about a subject or a schema id
- **history**: timeline from _schemas: registrations, deletes, rule changes
- **get**: every version of a subject, or of all subjects
- **get-compatibility**: the compatibility rule in force (subject or global)
- **get-mode / get-alias**

**✍️ Write**

- **register**: add a new version to a subject
- **check-compatibility**: would this schema be accepted? (nothing registered)
- **test-rules**: do these records pass the data contract rules?
- **validate**: accepted by Schema Registry X, refused by Y? (throwaway registries)
- **delete**: a version, or the whole subject
- **set-compatibility**: relax or tighten the evolution rule (subject or global)
- **set-mode**: READWRITE, READONLY or IMPORT (subject or global)
- **set-normalize, validate-new-schemas**: registry-wide behaviour
- **set-alias**: point one subject name at another

**📦 Move**

- **export / import**: a registry to a folder and back, keeping the ids
- **compare**: two registries (mdc clusters) or two contexts
- **exporter**: Schema Linking: create, list, status, pause…
- **contexts**: the contexts of the registry (`--context` on the commands)

🔀 diff compares two versions (or a version and a file) field by field,  
with the verdict of each compatibility rule.

🪄 derive-schema turns a sample payload into an avro, json schema or  
protobuf schema, which saves writing one by hand.

A subject is normally named after the topic: `<topic>`-key and  
`<topic>`-value. `playground topic delete` removes both along with the  
topic.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-schema  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%94%B0-schema-not-found-after-a-cleanup

## Usage

```bash
playground schema COMMAND
```

## Schema commands

- [list](playground%20schema%20list) - 📋 List the subjects of the registry
- [get](playground%20schema%20get) - 🔰 Get all schemas versions for specified subject (if `--subject` is not specified, all subjects will be used)
- [register](playground%20schema%20register) - ⏺️ Register a schema in specified subject
- [check-compatibility](playground%20schema%20check-compatibility) - 🧪 Check whether a schema would be accepted, without registering it
- [diff](playground%20schema%20diff) - 🔀 Compare two schemas field by field, with the verdict of each compatibility rule
- [describe](playground%20schema%20describe) - 🔎 Everything about one subject, or one schema id, in one call
- [history](playground%20schema%20history) - 📜 Timeline of the Schema Registry, from its _schemas topic
- [export](playground%20schema%20export) - 📦 Export the subjects of the registry to a folder
- [import](playground%20schema%20import) - 📥 Import schemas into the registry, keeping their ids
- [test-rules](playground%20schema%20test-rules) - 📏 Test the data contract rules of a subject against records
- [contexts](playground%20schema%20contexts) - 🗂️ List the contexts of the registry, with their number of subjects and mode
- [compare](playground%20schema%20compare) - 🔀 Compare the subjects of two registries (or two contexts)
- [exporter](playground%20schema%20exporter) - 🔗 Schema Linking: exporters that copy subjects to another registry
  - [create](playground%20schema%20exporter%20create) - 🔗 Create an exporter, then wait until it runs
  - [list](playground%20schema%20exporter%20list) - 📋 List the exporters of the registry, with their state
  - [status](playground%20schema%20exporter%20status) - 🚦 State of an exporter (RUNNING, PAUSED, ERROR with its trace), offset and number of objects exported
  - [pause](playground%20schema%20exporter%20pause) - ⏸️ Pause an exporter
  - [resume](playground%20schema%20exporter%20resume) - ▶️ Resume a paused exporter
  - [reset](playground%20schema%20exporter%20reset) - ⏮️ Reset a paused exporter: it exports everything again
  - [delete](playground%20schema%20exporter%20delete) - 🗑️ Delete a paused exporter (the exported schemas stay in the destination)
- [validate](playground%20schema%20validate) - 🧪 Register schemas in a throwaway Schema Registry of each CP version, and compare the verdicts
- [get-compatibility](playground%20schema%20get-compatibility) - 🛡️ Get the compatibility rule in force
- [set-compatibility](playground%20schema%20set-compatibility) - 🛡️ Set the compatibility rule of a subject (`--subject`), or of the whole registry (`--global`)
- [get-mode](playground%20schema%20get-mode) - 🔏 Get the mode in force
- [set-mode](playground%20schema%20set-mode) - 🔏 Set the mode of a subject (`--subject`), or of the whole registry (`--global`)
- [set-normalize](playground%20schema%20set-normalize) - 🧽 Set normalize at schema registry level
- [validate-new-schemas](playground%20schema%20validate-new-schemas) - 🩺 Validate new schemas (default is true since CP 8.2.0)
- [delete](playground%20schema%20delete) - 🧟 Delete schema
- [derive-schema](playground%20schema%20derive-schema) - 🪄 Derive a schema based on payload
- [set-alias](playground%20schema%20set-alias) - 🔯 Set a subject alias
- [get-alias](playground%20schema%20get-alias) - 🔯 Get subject alias


