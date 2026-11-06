# playground codespace create

👷 Create a GitHub Codespace of kafka-docker-playground, then open it

The codespace is created from the master branch (`--branch` to change it)  
on a 4-core / 16 GB machine, the minimum for a broker, Connect and Schema  
Registry. When a prebuild is configured for the repository, it starts  
with the default images already pulled; otherwise they are pulled in the  
background once it is open.

It is named pg-`<username>`-`<suffix>`, like the ec2 instances, so that  
`playground codespace list` tells them apart.

## Usage

```bash
playground codespace create [OPTIONS]
```

## Options

#### `--machine MACHINE`

🧑‍💻 machine size: 4-core (16 GB), 8-core (32 GB) or 16-core (64 GB). default is 4-core

🎓 Tip: an 8-core machine uses your quota twice as fast as a 4-core one

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `4-core`
| Allowed Values: | `4-core`, `8-core`, `16-core`

#### `--branch, -b BRANCH`

🌿 branch the codespace is created from. default is master

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `master`

#### `--suffix SUFFIX`

📮 suffix to add to the codespace display name, giving pg-`<username>`-`<suffix>`

if not set, the name is pg-`<username>`-\<6 random characters\>

🎓 Tip: set it to the case number you are working on

#### `--location LOCATION`

🌍 region of the codespace (default is picked by GitHub, close to you)

| Attributes      | &nbsp;
|-----------------|-------------
| Allowed Values: | `EastUs`, `SouthEastAsia`, `WestEurope`, `WestUs2`

#### `--no-open`

🙈 do not open the codespace in VS Code once it is created

#### `--push-secrets`

🔐 once it is available, send your secrets store to it (playground codespace push-secrets)

#### `--sync-repro-folder`

👉 once it is available, copy your reproduction-models folder to it (playground codespace sync-repro-folder local-to-codespace)

## Examples

```bash
playground codespace create
```

```bash
playground codespace create --suffix 123456 --machine 8-core
```

```bash
playground codespace create --branch my-feature --no-open
```

```bash
playground codespace create --suffix 123456 --push-secrets --sync-repro-folder
```


