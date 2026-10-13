# playground repro bootstrap

🛠  Bootstrap reproduction model, just run `<playground repro bootstrap>` !

🔥 HIGHLY RECOMMENDED: start in interactive mode by simple running `<playground repro bootstrap>` !

👉 Check documentation https://kafka-docker-playground.io/#/reusables?id=%f0%9f%9b%a0-bootstrap-reproduction-model

## Usage

```bash
playground repro bootstrap [OPTIONS]
```

## Options

#### `--file, -f FILE`

🔖 Example file to use as basis, if not set, currently running example is used

❕ It must be absolute full path

🎓 Tip: use `<tab>` completion to trigger fzf completion

#### `--description, -d DESCRIPTION`

💭 Description for the reproduction model

#### `--custom-smt`

🔧 Add a custom SMT (which is a no-op)

#### `--connector-plugin CONNECTOR-PLUGIN`

🔌 Add Connector plugin to `CONNECT_PLUGIN_PATH`

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes

#### `--pipeline SINK_FILE`

🔖 Sink example file to use for creating a pipeline. multiple `--pipeline` flags can be used to create a pipeline with multiple sinks.

❕ It must be absolute full path.

🎓 Tip: use `<tab>` completion to trigger fzf completion

| Attributes      | &nbsp;
|-----------------|-------------
| Repeatable:     |  ✓ Yes
| Conflicts With: | `--producer`

#### `--no-run`

🛑 Only generate the reproduction model files, then exit

Skips opening the generated file in the editor and running it, so  
the running environment is left untouched.

🎓 Tip: use it in scripts and from AI agents, together with `--file` and `--description`

## Examples

```bash
playground repro bootstrap (interactive mode)
```

```bash
playground repro bootstrap -f "$PWD/connect/connect-http-sink/http_no_auth.sh" -d "123456 dlq not working" --no-run
```


