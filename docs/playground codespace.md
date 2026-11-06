# playground codespace

☁️ Create and manage GitHub Codespaces to run kafka-docker-playground

🪄 Open them in Visual Studio Code (or the browser), or run a command in them over ssh

The same thing as the "Open in GitHub Codespaces" button, from the  
terminal: an Ubuntu x86_64 machine set up by .devcontainer/ (Docker with  
compose v2, fzf, playground in the PATH, the default images pulled), with  
nothing to install on your laptop and no AWS account. It is also where the  
examples that do not work on ARM64 run.

- **create**: create a codespace and open it
- **open**: open it in VS Code (or the browser with `--web`)
- **ssh**: a shell, or one command, in it
- **push-secrets**: send your credentials to its secrets store
- **sync-repro-folder**: keep reproduction-models in step, both directions
- **list / start / stop / delete**

A thin layer over 'gh codespace': it needs the GitHub CLI with the  
'codespace' scope (gh auth refresh -h github.com -s codespace).

💰 A running codespace uses your Codespaces quota (30 hours a month on 4  
cores with GitHub Free), then is billed. It stops by itself after 30  
minutes idle; `playground codespace stop` when you pause, and  
`playground codespace delete` when you are done (a stopped codespace  
still uses storage).

🔐 The private reproduction-models submodule is not cloned in a codespace:  
`playground codespace sync-repro-folder local-to-codespace` copies yours.

## Usage

```bash
playground codespace COMMAND
```

## Environment Variables

#### `PLAYGROUND_CODESPACE_REPO`

🐙 Repository the codespaces are created from, as OWNER/REPO (default vdesabou/kafka-docker-playground, set it to use your fork)

## Commands

- [create](playground%20codespace%20create) - 👷 Create a GitHub Codespace of kafka-docker-playground, then open it
- [list](playground%20codespace%20list) - 🔘 List your kafka-docker-playground codespaces
- [open](playground%20codespace%20open) - 👨‍💻 Open a codespace in Visual Studio Code
- [ssh](playground%20codespace%20ssh) - 🐚 Open a shell in a codespace, or run one command in it
- [stop](playground%20codespace%20stop) - 🔴 Stop a codespace
- [start](playground%20codespace%20start) - 🟢 Start a codespace
- [delete](playground%20codespace%20delete) - ❌ Delete a codespace
- [push-secrets](playground%20codespace%20push-secrets) - 🔐 Send the secrets store to a codespace
- [sync-repro-folder](playground%20codespace%20sync-repro-folder) - ↔️ Synchronize reproduction-models folder between local and a codespace
  - [local-to-codespace](playground%20codespace%20sync-repro-folder%20local-to-codespace) - 👉 Sync local reproduction-models folder to a codespace
  - [codespace-to-local](playground%20codespace%20sync-repro-folder%20codespace-to-local) - 👈 Sync a codespace reproduction-models folder to local


