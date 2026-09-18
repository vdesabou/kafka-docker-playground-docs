# playground tools

🧰 Tools commands  
  
Small utilities that are handy around the playground but are not tied to a  
running environment:  
  
  read-avro-file        dump an avro file as readable json  
  read-parquet-file     same, for parquet  
  certs-create          generate a keystore and truststore for a component  
  redos-check           check a topics.regex for catastrophic backtracking  
  install-vscode-extension   playground completion inside VS Code  
  
🎓 Tip: the file readers are what you use to check what a sink connector  
really wrote, after pulling the file out with 'playground container cp'.

## Usage

```bash
playground tools COMMAND
```

## == Commands ==

- [install-vscode-extension](playground%20tools%20install-vscode-extension) - 🪄 Install a slightly modified version of "Shell Script Command Completion" Visual Studio Code extension (https://marketplace.visualstudio.com/items?itemName=tetradresearch.vscode-h2o)
- [read-avro-file](playground%20tools%20read-avro-file) - 🔖 Read provided avro file
- [read-parquet-file](playground%20tools%20read-parquet-file) - 🔖 Read provided parquet file
- [certs-create](playground%20tools%20certs-create) - 🔐 Generate keys and certificates used for SSL
- [redos-check](playground%20tools%20redos-check) - 🪖 Check topics.regex for ReDos vulnerabilities using recheck (https://github.com/makenowjust-labs/recheck)


