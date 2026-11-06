# playground codespace delete

❌ Delete a codespace

This is what stops the storage billing for good, unlike stop. The branch  
and the uncommitted / unpushed state of each codespace are shown before  
you confirm.

⚠️ Everything in the codespace is lost, including the reproduction models  
you wrote there.

Without `--codespace`, it applies to all your codespaces, and asks you to  
confirm first.

## Usage

```bash
playground codespace delete [OPTIONS]
```

## Options

#### `--codespace, -c CODESPACE`

☁️ codespace name, as shown by `playground codespace list` (use completion)

🎓 Tip: if not specified, the most recently used codespace is used


