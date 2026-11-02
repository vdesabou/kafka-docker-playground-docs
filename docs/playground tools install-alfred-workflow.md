# playground tools install-alfred-workflow

🎩 Install the "kafka-docker-playground (kdp)" Alfred workflow (macOS, Alfred 5 with the Powerpack)

A launcher for the playground CLI: type 'kdp' in Alfred, or select text  
anywhere (a connector config, a stack trace, a connector class, a config  
key, a case number) and use the Universal Action "kdp: config, stack  
trace, connector class, key, case…":

- **kdp find `<words>`**: find-example: ↩ copies `playground run -f …`
- **kdp history [words]**: replay a past run with its exact flags
- **kdp plugin `<words>` [ver]**: pick a plugin, then a version, then info, changelog, source code, jars, CVEs
- **kdp key `<words>`**: pick a config key, then a connector: config-key
- **kdp docs [words]**: deep dive pages
- **kdp connector [words]**: pick a running connector: diagnose, status, tasks, metrics, history…
- **kdp logs [container] [pat]**: pick a container: errors, last lines, grep, follow
- **kdp topic / schema / ci**: pick a topic, a subject, a CI test: describe, records, history, CI result
- **kdp status**: status, connector status / diagnose, connect errors
- **kdp repro / notes / case**: reproduction models, notes, support cases (when present)

On a result: ↩ copies the command (or opens), ⌘ opens in VS Code, ⌃ runs  
it in the terminal (for an example, that stops the running environment),  
⌥ and ⇧ depend on the mode.

Read-only commands (plugin, key, status) show their output in the Alfred  
window, streamed while they run. "Show output" and "Run in the terminal"  
are workflow settings: the output can go to the terminal instead, and the  
terminal is the one set in Alfred (default), a new VS Code integrated  
terminal, Terminal.app, or copy only.

By default, builds the workflow from scripts/alfred-workflow/ and opens it  
in Alfred, which asks to import it: run the command again after a pull to  
update it. With `--link`, the folder is symlinked into your Alfred  
preferences instead, to work on it: Alfred does not watch the folder  
behind the link, so run the command again after an edit (it reloads the  
workflow in Alfred).  
Alfred then writes its settings to scripts/alfred-workflow/prefs.plist  
(ignored by git) and may rewrite info.plist when you edit the workflow in  
Alfred Preferences: check git diff before committing.

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


