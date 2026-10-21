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
`playground secrets` profile.

## Usage

```bash
playground repro import [OPTIONS]
```

## Options

#### `--file, -f FILE`

🤐 Bundle file (playground_repro_\*.tgz, any name is accepted)

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

## Examples

```bash
playground repro import -f ~/Downloads/playground_repro_http-repro-123456-dlq_2026-10-21.tgz
```

```bash
playground repro import -f ~/Downloads/playground_repro_http-repro-123456-dlq_2026-10-21.tgz --on-conflict rename
```


