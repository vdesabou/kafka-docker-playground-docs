# playground account mongodb-atlas setup

🛠️ Validate and store the MongoDB Atlas account of the MongoDB Atlas examples (fm-mongodb-atlas-sink, fm-mongodb-atlas-source)

Takes `MONGODB_ATLAS_HOST`, `MONGODB_ATLAS_USER` and `MONGODB_ATLAS_PASSWORD` from the environment, then the secrets store, else asks  
for them (secrets without echo), puts them in the form the examples use,  
validates them (the mongodb+srv record of the host and a ping with mongosh (mongo image)), then stores them with `playground secrets set`.  
Nothing is stored when the login fails.

## Usage

```bash
playground account mongodb-atlas setup [OPTIONS]
```

## Options

#### `--no-store`

📋 Print the export commands instead of storing the variables

## Examples

```bash
playground account mongodb-atlas setup
```


