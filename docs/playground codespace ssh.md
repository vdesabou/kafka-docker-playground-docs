# playground codespace ssh

🐚 Open a shell in a codespace, or run one command in it

Everything after -- runs in the codespace, from the repository folder, in  
a login shell (so playground is in the PATH). A stopped codespace is  
started on the way.

It needs the SSH server of .devcontainer/: a codespace created before it  
was added, or from a prebuild older than that, needs a rebuild first  
(gh codespace rebuild -c `<name>`).

Without `--codespace`, the most recently used codespace is used.

## Usage

```bash
playground codespace ssh [OPTIONS] [--] [COMMAND...]
```

## Options

#### `--codespace, -c CODESPACE`

☁️ codespace name, as shown by `playground codespace list` (use completion)

🎓 Tip: if not specified, the most recently used codespace is used

## Examples

```bash
playground codespace ssh
```

```bash
playground codespace ssh -- playground status
```

```bash
playground codespace ssh --codespace pg-jdoe-123456 -- docker images
```


