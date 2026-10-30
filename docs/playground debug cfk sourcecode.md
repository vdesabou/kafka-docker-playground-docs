# playground debug cfk sourcecode

🧑‍💻 Source code of the CFK operator at the version of a cluster or of a support bundle

The helm chart version of CFK (0.1718.10 for CFK 3.3.0) is also the image tag of the operator and the git tag  
(v0.1718.10) of its source, in the private repository confluentinc/confluent-operator (Confluent only: gh auth  
login, VPN). The tag is cloned once, shallow, in /tmp/cfk-operator-sourcecode/confluent-operator-v`<tag>`, and the  
folder is printed as the last line, for an agent or an engineer to read the code that logs an error.

`--grep` "`<message>`" searches a literal part of an operator message in the code (tests and vendor left out), with  
the GitHub link of each match. With `--compare-with` `<version>`, it also says whether the message is still there in  
another version, and which of its files changed (is it fixed after X?).

🍪 Deep dive: https://kafka-docker-playground.io/#/deep-dive-cfk

## Usage

```bash
playground debug cfk sourcecode [OPTIONS]
```

## Dependencies

#### *git*

visit https://git-scm.com/downloads to install

## Options

#### `--cfk-version VERSION`

🔢 CFK version (3.3.0), mapped to its operator tag

#### `--operator-tag TAG`

🏷️ Operator tag, the helm chart version (0.1718.10)

#### `--bundle, -f BUNDLE`

📦 CFK support bundle (folder, .tar.gz, .tgz, .zip): its operator version (cluster-details.txt, operator Deployment)

#### `--grep MESSAGE`

🔎 Literal text to search in the code, a part of an operator log message ("cluster not rollable from roll pre checks")

#### `--compare-with VERSION`

🆚 Another CFK version or operator tag: whether the `--grep` text is still there, which files changed, the GitHub compare link

#### `--only-show-url`

🔗 Only print the GitHub URL of the tag (and of the comparison with `--compare-with`), no clone

#### `--checkout-only`

📂 Clone the tag and print its folder as the last line (also what the command does without `--grep` / `--compare-with`)

## Examples

```bash
playground debug cfk sourcecode --cfk-version 3.3.0 --only-show-url
```

```bash
playground debug cfk sourcecode --bundle ./support-bundle-ns-confluent.tar.gz --grep "cluster not rollable from roll pre checks"
```

```bash
playground debug cfk sourcecode --cfk-version 3.2.3 --grep "missing inter replication credentials" --compare-with 3.3.0
```

```bash
playground debug cfk sourcecode --operator-tag 0.1718.10 --checkout-only
```


