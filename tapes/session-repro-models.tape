# 🎓 Bite size session: the life of a reproduction model: bootstrap it from an example, edit it, run it, check it for
# secrets, export it as a bundle for a colleague, import it (narrated with comments typed in the terminal)
# off camera (scripts/generate-session-videos.sh): an empty reproduction-models folder (the private submodule is not
# checked out: the session only shows the model it creates, removed by the teardown), the clipboard disabled, an empty
# run history (export takes the run line of the model from it), /tmp/kdp-session-repro for the bundle. The tape points
# PLAYGROUND_SECRETS_DIR to an empty folder (off camera): the secret scan of check / export then does not read the
# secrets store of the machine (no keychain / 1Password prompt, no "reading the N credentials" line)
# The session runs the model once (plaintext FileStream sink, about 1 min 30 s), the wait is cut
Output docs/videos/session-repro-models-terminal.mp4
Source tapes/settings.tape
Set Width 1400
Set Height 820
Source tapes/prelude.tape

Hide
Type "export PLAYGROUND_SECRETS_DIR=/tmp/kdp-session-secrets && clear"
Enter
Sleep 300ms
Show

# ── 1. bootstrap ────────────────────────────────────────────────────────────
Type@15ms "# 🎓 Bite size session: a reproduction model is an example rewritten to show ONE problem, that anyone runs with one command"
Enter
Sleep 2s
Type@15ms "# New case: start from the closest example. -f takes an absolute path, -d the description (6 leading digits = the case number)"
Enter
Sleep 3s
Type@15ms "# --no-run: generate the files and return (without it, bootstrap opens your editor and runs the model right away)"
Enter
Sleep 2s
Type "playground repro bootstrap -f $PWD/connect/connect-filestream-sink/filestream-sink.sh -d '000000 bite size session' --no-run"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 6s
Type@15ms "# ✨ a new script and its own copy of the docker compose override, in reproduction-models/<folder of the example>"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 2. what was generated ───────────────────────────────────────────────────
Type "m=$PWD/reproduction-models/connect-connect-filestream-sink/filestream-sink-repro-000000-bite-size-session.sh"
Sleep 800ms
Enter
Sleep 500ms
Type "head -16 $m"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 6s
Type@15ms "# a header the tools rely on: date, author, description, 🔮 ticket link, documentation, and a 💬 comments block for expected vs actual"
Enter
Sleep 3s
Type "ls -A ${m%/*}; readlink ${m%/*}/README.md"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@15ms "# README.md, stop.sh, config-*: symlinks to the public example, they follow it. Only the .sh and the .yml are yours"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 3. edit, then run ───────────────────────────────────────────────────────
Type@15ms "# Build the scenario: here 10 records instead of 5, and expected vs actual in the header"
Enter
Sleep 2s
Type "perl -i -pe 's/nb-messages 5/nb-messages 10/; s/comments:/comments: expected 10 lines in the output file/' $m"
Sleep 800ms
Enter
Sleep 1s
Type "grep -n -e 'comments:' -e 'nb-messages' $m"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 4s
Type@15ms "# A model runs like any example (in a model, create-or-update warns instead of stopping when the connector is not RUNNING)"
Enter
Sleep 2s
Type "playground run -f $m"
Sleep 800ms
Enter
Sleep 4s
# the run takes about a minute and a half: cut it
Hide
Wait@15m /❯\s*$/
Show
Sleep 4s
Type "playground container exec -c connect --command 'wc -l /tmp/output.json'"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 3s
Type@15ms "# ✅ 10 lines. The run line is now in the history: export will put it in the bundle"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 4. check ────────────────────────────────────────────────────────────────
Type@15ms "# Before sharing: does it hold a secret? Say an AWS key slipped in while testing (a fake one, in the AWS format)"
Enter
Sleep 2s
Type "echo '# aws_access_key_id = AKIAABCDEFGHIJKLMNOP' >> $m"
Sleep 800ms
Enter
Sleep 500ms
Type "playground repro check -f $m; echo exit=$?"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 6s
Type@15ms "# 🔥 blocked, exit 1: file, line and kind, never the value. Values of known credentials and token formats block, emails or public IPs only warn"
Enter
Sleep 3s
Type@15ms "# Remove it (a real one goes to playground secrets, the script uses ${VAR})"
Enter
Sleep 1s
Type "perl -i -ne 'print unless /AKIAABCDEFGHIJKLMNOP/' $m"
Sleep 800ms
Enter
Sleep 1s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 5. export ───────────────────────────────────────────────────────────────
Type@15ms "# Hand it to a colleague: one self-contained bundle. --dry-run first: what goes in, and the same secret scan"
Enter
Sleep 2s
Type "playground repro export -f $m --dry-run"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 7s
Type@15ms "# ▶️  the run line from the history, the symlinks stored as their content, ✅ no secret nor customer data found"
Enter
Sleep 3s
Type "playground repro export -f $m --output /tmp/kdp-session-repro --no-clipboard"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@15ms "# 📤 a .tgz with a repro-manifest.json: run line, case, author, base example, credential names (never values), sha256 of every file"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 6. import ───────────────────────────────────────────────────────────────
Type@15ms "# On the colleague's machine (here: the same one, without the model)"
Enter
Sleep 1s
Type "rm $m ${m%/*}/docker-compose.plaintext.repro-000000-bite-size-session.yml"
Sleep 800ms
Enter
Sleep 500ms
Type "playground repro import -f /tmp/kdp-session-repro/playground_repro_*.tgz --dry-run"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 6s
Type@15ms "# ✨ new: the model and its override, 🟰 identical: the public files they already have. A file that differs is a conflict: --on-conflict rename|overwrite"
Enter
Sleep 3s
Type "playground repro import -f /tmp/kdp-session-repro/playground_repro_*.tgz"
Sleep 800ms
Enter
Wait@1m /❯\s*$/
Sleep 5s
Type@15ms "# 📥 imported, the model is now the current one, ▶️  and the line to run it, with the flags of the exporter"
Enter
Sleep 3s
Hide
Type "clear"
Enter
Sleep 300ms
Show

# ── 7. recap ────────────────────────────────────────────────────────────────
Type@15ms "# 🧰 The life of a model:"
Enter
Sleep 1s
Type@15ms "#   playground repro bootstrap -f <example> -d '<case> <symptom>' --no-run   🛠️  scaffold (without flags: menus)"
Enter
Sleep 2s
Type@15ms "#   playground run -f <model>                                              ▶️  run it once (for the run line)"
Enter
Sleep 2s
Type@15ms "#   playground repro check -f <model>                                      🕵️  secrets, customer data (also a pre-commit hook)"
Enter
Sleep 2s
Type@15ms "#   playground repro export -f <model> --dry-run                           📤 then without --dry-run, attach the bundle"
Enter
Sleep 2s
Type@15ms "#   playground repro import -f <bundle.tgz> --dry-run                      📥 then without --dry-run, run the printed line"
Enter
Sleep 3s
Type@15ms "# 💡 one issue per model, expected vs actual in 💬 comments, neutral names, never customer data"
Enter
Sleep 6s
