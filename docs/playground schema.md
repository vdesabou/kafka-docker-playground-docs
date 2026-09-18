# playground schema

🔰 Schema commands  
  
Talk to the Schema Registry of the running environment, whether it is the  
local container or the one in Confluent Cloud, without building the urls  
and the credentials yourself.  
  
🔍 Read  
  get                  every version of a subject, or of all subjects  
  get-compatibility    the compatibility rule in force  
  get-mode / get-alias  
  
✍️ Write  
  register             add a new version to a subject  
  delete               a version, or the whole subject  
  set-compatibility    relax or tighten the evolution rule  
  set-mode             READWRITE, READONLY or IMPORT  
  set-normalize, validate-new-schemas   registry-wide behaviour  
  set-alias            point one subject name at another  
  
🪄 derive-schema turns a sample payload into an avro, json schema or  
protobuf schema, which saves writing one by hand.  
  
A subject is normally named after the topic: \<topic\>-key and  
\<topic\>-value. 'playground topic delete' removes both along with the  
topic.

## Usage

```bash
playground schema COMMAND
```

## Schema commands

- [get](playground%20schema%20get) - 🔰 Get all schemas versions for specified subject (if --subject is not specified, all subjects will be used)
- [register](playground%20schema%20register) - ⏺️ Register a schema in specified subject
- [get-compatibility](playground%20schema%20get-compatibility) - 🛡️ Get subject-level compatibility
- [set-compatibility](playground%20schema%20set-compatibility) - 🛡️ Set subject-level compatibility
- [get-mode](playground%20schema%20get-mode) - 🔏 Get subject-level mode
- [set-mode](playground%20schema%20set-mode) - 🔏 Set subject-level mode
- [set-normalize](playground%20schema%20set-normalize) - 🧽 Set normalize at schema registry level
- [validate-new-schemas](playground%20schema%20validate-new-schemas) - 🩺 Validate new schemas (default is true since CP 8.2.0)
- [delete](playground%20schema%20delete) - 🧟 Delete schema
- [derive-schema](playground%20schema%20derive-schema) - 🪄 Derive a schema based on payload
- [set-alias](playground%20schema%20set-alias) - 🔯 Set a subject alias
- [get-alias](playground%20schema%20get-alias) - 🔯 Get subject alias


