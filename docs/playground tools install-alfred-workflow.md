# playground tools install-alfred-workflow

🎩 Install the "kafka-docker-playground (kdp)" Alfred workflow (macOS, Alfred 5 with the Powerpack)

A launcher for the playground CLI: type 'kdp' in Alfred, or select text  
anywhere and use the Universal Action "kdp: support case, example, config  
key…":

- **kdp find `<words>`**: find-example: ↩ copies `playground run -f …`
- **kdp history [words]**: replay a past run with its exact flags
- **kdp plugin `<p>` [version]**: connector-plugin info, changelog, source code, jars, CVEs
- **kdp key `<key>` [class]**: connector-plugin config-key
- **kdp docs [words]**: deep dive pages
- **kdp status**: status, connector status / diagnose, connect errors
- **kdp repro / notes / case**: reproduction models, notes, support cases (when present)

On a result: ↩ copies the command (or opens), ⌘ opens in VS Code, ⌃ runs  
it in the terminal set in Alfred (for an example, that stops the running  
environment), ⌥ and ⇧ depend on the mode.

By default, builds the workflow from scripts/alfred-workflow/ and opens it  
in Alfred, which asks to import it: run the command again after a pull to  
update it. With `--link`, the folder is symlinked into your Alfred  
preferences instead, so changes to the source are live (to work on it).

👉 Check documentation https://kafka-docker-playground.io/#/cli?id=%f0%9f%8e%a9-alfred-workflow-macos

## Usage

```bash
playground tools install-alfred-workflow [OPTIONS]
```

## Dependencies

#### *zip*

install it with your package manager (brew install zip)

#### *python3*

install it with 'xcode-select `--install`' or 'brew install python'

## Options

#### `--link`

🔗 Symlink scripts/alfred-workflow/ into the Alfred preferences instead of importing a copy

Changes to the source are live, for development. Replaces an existing  
symlink, never a workflow folder.

## Examples

```bash
playground tools install-alfred-workflow
```

```bash
playground tools install-alfred-workflow --link
```


