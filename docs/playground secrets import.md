# playground secrets import

📥 Import an existing secret.properties / variable.properties file  
  
Each KEY=value line is classified and stored in the right place. A  
leading 'export', comments, blank lines and one level of surrounding  
quotes are handled; anything that is not an uppercase variable name is  
skipped and reported.  
  
This is the one step migration away from 'source secret.properties'.

## Usage

```bash
playground secrets import [OPTIONS]
```

## Options

#### *--file FILE*

📄 File to import

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *--shred*

🔥 Securely delete the source file after a successful import

#### *--secret*

🔐 Treat every line as a credential, whatever the variable names are

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--plain*

#### *--plain*

📝 Treat every line as a non sensitive variable  
  
That is what a variables.properties file usually is: regions, project  
ids, account names, URLs.

| Attributes      | &nbsp;
|-----------------|-------------
| Conflicts With: | *--secret*

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets import --file ~/secret.properties
```

```bash
playground secrets import --file ~/secret.properties --shred
```

```bash
playground secrets import --file ~/variables.properties --plain
```


