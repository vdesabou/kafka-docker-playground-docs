# playground tools http-server set-response

🎛️ Set how the http test server answers

Any combination of a status code, a JSON body, a delay, and closing the  
connections without answering (to reproduce 'Connection reset' and  
'Unexpected end of stream' errors). The body can also come on stdin  
(heredoc). The settings stay until the next set-response or reset.

## Usage

```bash
playground tools http-server set-response [OPTIONS]
```

## Options

#### `--container, -c CONTAINER`

🐳 Container of the http test server (default httpserver)

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `httpserver`

#### `--status-code STATUS_CODE`

🔢 HTTP status code of the responses (200, 400, 429, 500...)

#### `--body BODY`

📄 JSON object or array sent back as response body (or on stdin)

#### `--delay DELAY`

⏳ Delay in milliseconds before answering (0 for none), to reproduce timeouts

#### `--close-connection`

✂️ Close the connections without answering, until reset

## Examples

```bash
playground tools http-server set-response --status-code 500
```

```bash
playground tools http-server set-response --status-code 429 --delay 2000
```

```bash
playground tools http-server set-response << 'EOF'
{"store": {"book": [{"category": "reference", "price": 8.95}]}}
EOF
```

```bash
playground tools http-server set-response --close-connection
```


