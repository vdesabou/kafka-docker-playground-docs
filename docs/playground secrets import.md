# playground secrets import

📥 Import an existing secret.properties / variable.properties file  
  
Each KEY=value line is classified and stored in the right place.

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

#### *--profile PROFILE*

🗂️ Secrets profile to use (default is the active one)

## Examples

```bash
playground secrets import --file ~/secret.properties
```

```bash
playground secrets import --file ~/secret.properties --shred
```


