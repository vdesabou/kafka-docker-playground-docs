# playground codespace sync-repro-folder

↔️ Synchronize reproduction-models folder between local and a codespace

reproduction-models is a private submodule: a codespace cannot clone it,  
and the models you write there are lost with the codespace. These two  
commands copy that folder in one direction or the other with rsync, over  
the ssh tunnel of 'gh codespace ssh' (only newer files, .git and what  
.gitignore lists are left out, nothing is deleted on the other side).

- **local-to-codespace**: push what you wrote locally, before running it there
- **codespace-to-local**: pull back what you wrote there, before deleting it

`playground codespace create --sync-repro-folder` runs local-to-codespace  
for you.

⚠️ Get into the habit of running codespace-to-local before  
`playground codespace delete`, nothing else brings those files back.

## Usage

```bash
playground codespace sync-repro-folder COMMAND
```

## Dependencies

#### *rsync*

rsync needs to be installed

## Commands

- [local-to-codespace](playground%20codespace%20sync-repro-folder%20local-to-codespace) - 👉 Sync local reproduction-models folder to a codespace
- [codespace-to-local](playground%20codespace%20sync-repro-folder%20codespace-to-local) - 👈 Sync a codespace reproduction-models folder to local


