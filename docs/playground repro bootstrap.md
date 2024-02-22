# playground repro bootstrap

🛠  Bootstrap reproduction model  
  
👉 Check documentation https://kafka-docker-playground.io/#/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model

## Usage

```bash
playground repro bootstrap [OPTIONS] [ARGUMENTS...]
```

## Options

#### *--file, -f FILE*

🔖 Example file to use as basis, if not set, currently running example is used  
  
❕ It must be absolute full path  
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

#### *--description, -d DESCRIPTION*

💭 Description for the reproduction model

#### *--custom-smt*

🔧 Add a custom SMT (which is a no-op)

#### *--pipeline SINK_FILE*

🔖 Sink example file to use for creating a pipeline. multiple --pipeline flags can be used to create a pipeline with multiple sinks.  
  
❕ It must be absolute full path.   
  
🎓 Tip: use \<tab\> completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | *--producer*

## Examples

```bash
playground repro bootstrap (interactive mode)
```

```bash
playground repro bootstrap -f hdfs2<tab> -d "simple test"
```

```bash
playground repro bootstrap -f /full/path/hdfs2-sink.sh -d "testing with avro producer" --producer avro --producer-schema-value myschema<tab>
```

```bash
playground repro bootstrap -f hdfs2<tab> -d "testing with 2 protobuf producers" --producer protobuf --nb-producers 2
```

```bash
playground repro bootstrap -f hdfs2<tab> -d "testing custom smt" --custom-smt
```

```bash
playground repro bootstrap -f debeziumpostgres<tab> -d "create pipeline" --pipeline jdbcsink<tab>
```


