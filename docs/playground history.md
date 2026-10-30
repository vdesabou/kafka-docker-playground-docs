# playground history

🏰 Get an history of the examples which were run with run command and run it again

Opens a picker over every `playground run` command you have executed,  
most recent first and de-duplicated. The command you select is shown for  
editing before it runs, so you can change a `--tag` or add a flag on the way.

The runs are kept in playground-run-history (repository root), one  
shell-quoted line each: eval the last line to replay it from a script.  
Runs whose script no longer exists are not shown. `--cluster-creds` and `--cluster-schema-registry-creds` are written as  
'`<masked>`': they are taken from playground.ini when the run used the  
cluster saved there, otherwise replace '`<masked>`' when editing the line.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-run-and-versions  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%95%B9%EF%B8%8F-run-an-example-with-the-menu-or-with-flags

## Usage

```bash
playground history
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install


