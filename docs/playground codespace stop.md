# playground codespace stop

🔴 Stop a codespace

Shuts the machine down while keeping its disk, so you stop using compute  
and find your work again on `playground codespace start`. A codespace  
also stops by itself after 30 minutes idle.

Without `--codespace`, all your running codespaces are stopped.

## Usage

```bash
playground codespace stop [OPTIONS]
```

## Options

#### `--codespace, -c CODESPACE`

☁️ codespace name, as shown by `playground codespace list` (use completion)

🎓 Tip: if not specified, the most recently used codespace is used


