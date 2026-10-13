# playground consumer-group list

👥 List consumer groups

## Usage

```bash
playground consumer-group list [OPTIONS]
```

## Options

#### *--state*

🚦 Also display the state of each group (Stable, Empty, PreparingRebalance...)

#### *--verbose, -v*

🐞 Show command being ran.

## Examples

```bash
playground consumer-group list
```

```bash
playground consumer-group list --state
```

## Example output

```text
$ playground consumer-group list
17:22:17 ℹ️ 👥 Listing consumer groups
connect-filestream-sink
```


