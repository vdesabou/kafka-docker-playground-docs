# playground codespace open

👨‍💻 Open a codespace in Visual Studio Code

Opens your local VS Code connected to the codespace (it needs the GitHub  
Codespaces extension), or VS Code in the browser with `--web`. A stopped  
codespace is started on the way.

Without `--codespace`, the most recently used codespace is opened.

## Usage

```bash
playground codespace open [OPTIONS]
```

## Options

#### `--codespace, -c CODESPACE`

☁️ codespace name, as shown by `playground codespace list` (use completion)

🎓 Tip: if not specified, the most recently used codespace is used

#### `--web, -w`

🌐 open VS Code in the browser instead of the local VS Code

## Examples

```bash
playground codespace open
```

```bash
playground codespace open --web
```


