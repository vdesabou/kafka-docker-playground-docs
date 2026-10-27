# playground config display-last-updated-connector-plugins

🆕 at the end of a self-managed connector run, list the connector plugins released recently on Confluent Hub (default false)

Same as `playground connector-plugin display-last-updated`, computed  
in the background during the run. Look-back window and vendor are set  
with display-last-updated-connector-plugins-days and  
display-last-updated-connector-plugins-vendor.

## Usage

```bash
playground config display-last-updated-connector-plugins [ENABLED]
```

## Arguments

#### `ENABLED`



| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | `true`
| Allowed Values: | `true`, `false`

## Examples

```bash
playground config display-last-updated-connector-plugins false
```

```bash
playground config display-last-updated-connector-plugins true
```


