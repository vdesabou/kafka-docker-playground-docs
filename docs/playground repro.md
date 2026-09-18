# playground repro

👷‍♂️ Reproduction model commands  
  
A reproduction model is an example written to demonstrate one specific  
problem, so that anyone can reproduce it with a single command.  
  
  bootstrap   scaffold one from an existing example, then edit it  
  export      package the models you have not committed, as a tgz  
  import      unpack a tgz someone sent you, and run it  
  
👉 Always scaffold with bootstrap rather than copying a script by hand: it  
creates the header, the docker compose override, the CLI cheat sheet and  
registers the model, which a hand-written file would be missing.  
  
Keep a model minimal and about one issue, state expected versus actual  
behaviour in its comments header, and never put customer data in it.

## Usage

```bash
playground repro COMMAND
```

## Dependencies

#### *fzf*

visit https://github.com/junegunn/fzf#installation to install

## Environment Variables

#### *OUTPUT_FOLDER*

📁 Output folder where to generate bootstrapped files

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | reproduction-models

## == Commands ==

- [export](playground%20repro%20export) - 📤 Export as tgz file uncommitted reproduction models from the folder of current reproduction model
- [import](playground%20repro%20import) - 📥 Import tgz file which was created with export command
- [bootstrap](playground%20repro%20bootstrap) - 🛠  Bootstrap reproduction model, just run \<playground repro bootstrap\> !


