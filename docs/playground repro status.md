# playground repro status

🩹 Show or update what a reproduction model proves, from its header

`playground repro bootstrap` writes these fields under '# 💬 comments:'  
in the header of the model, one line each:

# 🎯 expected: what should happen  
# 💥 actual: what happens instead (the problem)  
# 🎫 jira: the Jira of the problem  
# 🩹 status: open, fixed in `<version>`, not a bug, customer config…

Without flag, prints the fields with the description, case, author and  
base example (`--json` for scripts). With `--set`, `--expected`, `--actual` or  
`--jira`, updates the lines, then prints them. A model created before the  
fields existed gets the missing lines added after '# 💬 comments:'.

`playground repro export` copies the fields into repro-manifest.json,  
and `playground repro import` prints them.

Without `--file`, the current reproduction model is used.

## Usage

```bash
playground repro status [OPTIONS]
```

## Options

#### `--file, -f FILE`

🔖 Reproduction model script (default: current one)

#### `--set STATUS`

🩹 New status, for example: open, fixed in 10.8.3, not a bug, customer config, workaround

#### `--expected EXPECTED`

🎯 New expected behaviour

#### `--actual ACTUAL`

💥 New actual behaviour

#### `--jira JIRA`

🎫 New Jira (a key like CC-1234 becomes its link)

#### `--json`

🤖 Print the fields as JSON

## Examples

```bash
playground repro status
```

```bash
playground repro status -f ~/kafka-docker-playground/reproduction-models/connect-connect-http-sink/http-repro-123456-dlq.sh --set "fixed in 10.8.3" --jira CC-1234
```

```bash
playground repro status --actual "the task fails with Unknown magic byte" --json
```


