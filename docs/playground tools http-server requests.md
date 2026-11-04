# playground tools http-server requests

📥 Show the requests received by the http test server

The current settings, then the last requests (oldest first): number,  
time, method, url, status sent back (or 'connection closed'), content  
type and size, and the body (300 characters, `--full` for all of it). The  
server keeps the last 1000 requests since its start or the last reset.

With `--min-expected-requests`, waits until that many requests (matching  
`--method` and `--grep`) were received, instead of a sleep in an example.

## Usage

```bash
playground tools http-server requests [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of the http test server (default httpserver)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `httpserver`

#### `--last LAST`

🔢 Number of requests to show, the most recent ones (0 for all the kept ones, default 20)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `20`

#### `--method METHOD`

🔀 Only the requests with this method (GET, POST, PUT...)

#### `--grep GREP`

🔎 Only the requests whose url or body match this regex

#### `--headers`

📨 Show the headers of each request

#### `--full`

📜 Show whole bodies, not only the first 300 characters

#### `--json`

📗 Print {"settings", "total", "kept", "matched", "requests": [...]} and nothing else

#### `--min-expected-requests MIN_EXPECTED_REQUESTS`

⏳ Wait until at least this number of matching requests were received

#### `--max-wait MAX_WAIT`

⏳ Max time in seconds to wait with `--min-expected-requests` (default 60)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `60`

#### `--clear`

🧹 Forget the received requests after showing them

## Examples

```bash
playground tools http-server requests
```

```bash
playground tools http-server requests --last 5 --headers
```

```bash
playground tools http-server requests --method POST --grep '"product":"foo"' --full
```

```bash
playground tools http-server requests --min-expected-requests 2 --max-wait 120
```

```bash
playground tools http-server requests --json | jq -r '.requests[].status'
```


