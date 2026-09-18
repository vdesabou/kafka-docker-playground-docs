# playground secrets edit

✏️ Open the store in your editor  
  
secrets.ini by default, env.ini with --plain. Unless the backend is  
file, secrets.ini holds references and not values, so this is where you  
rename a variable or move one between profiles, not where you read a  
password.  
  
Uses the config key editor, then the EDITOR environment variable, then  
vi.

## Usage

```bash
playground secrets edit [OPTIONS]
```

## Options

#### *--plain*

📝 Edit the non sensitive variables instead of the secrets

## Examples

```bash
playground secrets edit
```

```bash
playground secrets edit --plain
```


