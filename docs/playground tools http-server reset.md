# playground tools http-server reset

🔄 Reset the http test server

Back to the defaults: status 200, no delay, {} as body, connections kept  
open. The received requests are forgotten too, unless `--keep-requests`.

## Usage

```bash
playground tools http-server reset [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of the http test server (default httpserver)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `httpserver`

#### `--keep-requests`

📥 Keep the requests received so far

## Examples

```bash
playground tools http-server reset
```

```bash
playground tools http-server reset --keep-requests
```


