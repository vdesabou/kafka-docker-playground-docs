# playground repro

👷‍♂️ Reproduction model commands

A reproduction model is an example written to demonstrate one specific  
problem, so that anyone can reproduce it with a single command.

- **bootstrap**: scaffold one from an existing example, then edit it
- **status**: show or update what a model proves: expected, actual, jira, status
- **assert**: end a model with its verdict: 🐞 reproduced or ✅ not reproduced
- **export**: package one or more models as a self-contained tgz bundle
- **import**: unpack a bundle someone sent you, and run it
- **check**: scan models for secrets and customer data before committing them

👉 Always scaffold with bootstrap rather than copying a script by hand: it  
creates the header, the docker compose override, the CLI cheat sheet and  
registers the model, which a hand-written file would be missing.

Keep a model minimal and about one issue, state expected versus actual  
behaviour in its header (🎯 expected / 💥 actual), and never put customer  
data in it.

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-reproduction-models  
🎬 Bite size session: https://kafka-docker-playground.io/#/sessions?id=%F0%9F%A7%AA-the-life-of-a-reproduction-model

## Usage

```bash
playground repro COMMAND
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Environment Variables

#### `OUTPUT_FOLDER`

📁 Output folder where to generate bootstrapped files

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `reproduction-models`

## Commands

- [export](playground%20repro%20export) - 📤 Export reproduction models as a self-contained tgz bundle
- [check](playground%20repro%20check) - 🕵️ Scan reproduction models for secrets and customer data before they are committed
- [import](playground%20repro%20import) - 📥 Import a tgz bundle created by `playground repro export`
- [bootstrap](playground%20repro%20bootstrap) - 🛠  Bootstrap reproduction model, just run `<playground repro bootstrap>` !
- [status](playground%20repro%20status) - 🩹 Show or update what a reproduction model proves, from its header
- [assert](playground%20repro%20assert) - 🧪 End a reproduction model with its verdict: 🐞 REPRODUCED or ✅ NOT REPRODUCED


