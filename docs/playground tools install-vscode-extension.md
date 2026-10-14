# playground tools install-vscode-extension

🪄 Install a slightly modified version of "Shell Script Command Completion" Visual Studio Code extension (https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)

Gives you the same completion inside VS Code as in your terminal: while  
editing an example or a reproduction model, playground commands, flags  
and their allowed values are proposed as you type, with the help text  
on hover. Worth the two minutes of setup if you write example scripts.

It is installed as "Shell Script Command Completion (kafka-docker-playground)"  
(tetradresearch.vscode-h2o-playground), in place of the marketplace one,  
so that VS Code does not auto-update it with the unpatched version. Run  
the command again to get a newer upstream version.

After installation, install "playground" command:

- Go on a .sh file

- Type Ctrl+Shift+P (or ⌘+⇧+P on macOS) and choose "Shell Completion: Load Command Spec (experimental)" and then type "playground"

🔖 The command spec is downloaded from the master branch: commands added in a local branch are only proposed once merged. Run "Load Command Spec" again to refresh it.

👉 Check documentation https://kafka-docker-playground.io/#/cli?id=%f0%9f%aa%84-setup-shell-script-command-completion-visual-studio-code-extension

## Usage

```bash
playground tools install-vscode-extension
```

## Dependencies

#### *code*

visit https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line to install

#### *curl*

visit https://curl.se/download.html to install

#### *jq*

visit https://jqlang.github.io/jq/download/ to install

#### *unzip*

install it with your package manager (brew install unzip, apt-get install unzip)

#### *zip*

install it with your package manager (brew install zip, apt-get install zip)

## Examples

```bash
playground tools install-vscode-extension
```


