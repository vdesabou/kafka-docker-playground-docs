# playground repro import

📥 Import a tgz bundle created by `playground repro export`

The bundle is extracted to a temporary folder first and checked: no  
absolute paths, no '..', no special files, and the sha256 of every file  
must match its manifest. Bundles from older versions, without manifest,  
are still accepted.

Files identical to yours are skipped. When a file differs, the import  
stops unless `--on-conflict` says what to do. Files that were symlinks to  
a public example are restored as symlinks when the public file is  
identical, otherwise their content is kept.

Then the model becomes the current one, and the command prints the  
`playground run` line to use and the credentials missing from your  
`playground secrets` profile. `--run` goes on with that line when  
nothing is missing (in a terminal, it asks first when containers are  
running: the run stops them).

`--file` also takes a URL (a GitHub release asset, a raw file, any public  
link): the bundle is downloaded into an empty temporary folder, then  
checked like a local one. Links that need a login (Slack, Google  
Drive) must be downloaded by hand.

## Usage

```bash
playground repro import [OPTIONS]
```

## Options

#### `--file, -f FILE`

🤐 Bundle file (playground_repro_\*.tgz, any name is accepted), or its https:// URL

🎓 Tip: use `<tab>` completion to trigger fzf completion  
use playground config folder_zip_or_jar `<folder1>` `<folder2>`... (default is home folder and current folder is always included) to configure where to search the files

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### `--on-conflict ON-CONFLICT`

⚔️ What to do when a file of the bundle differs from your copy

abort: import nothing and list the differences  
rename: import the differing files with an -imported-`<date>` suffix (references in the imported scripts are updated)  
overwrite: replace your copy

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `abort`
| Allowed Values: | `abort`, `rename`, `overwrite`

#### `--dry-run`

🔍 Only show the manifest, the files and the conflicts

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | `--run`

#### `--run`

▶️ Then run the model with its run line (bundle with one model, nothing missing: credentials, external files)

## Examples

```bash
playground repro import -f ~/Downloads/playground_repro_http-repro-123456-dlq_2026-10-21.tgz
```

```bash
playground repro import -f ~/Downloads/playground_repro_http-repro-123456-dlq_2026-10-21.tgz --run
```

```bash
playground repro import -f https://github.com/<owner>/<repo>/releases/download/v1/playground_repro_http-repro-123456-dlq_2026-10-21.tgz
```

```bash
playground repro import -f ~/Downloads/playground_repro_http-repro-123456-dlq_2026-10-21.tgz --on-conflict rename
```


