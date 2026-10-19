# 👷 Turn an example into a reproduction model
Output docs/videos/repro-bootstrap.mp4
Source tapes/settings.tape
Source tapes/prelude.tape

Hide
Type "rm -rf reproduction-models/connect-connect-http-sink && clear"
Enter
Sleep 1s
Show

Type 'playground repro bootstrap -f "$PWD/connect/connect-http-sink/http_no_auth.sh" -d "dlq not working" --no-run'
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 3s
Type "head -12 reproduction-models/connect-connect-http-sink/http_no_auth-repro-dlq-not-working.sh"
Sleep 500ms
Enter
Sleep 5s

Hide
Type "rm -rf reproduction-models/connect-connect-http-sink"
Enter
