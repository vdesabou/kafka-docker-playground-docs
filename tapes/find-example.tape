# 🔎 Find an example, then run it with the versions you need
Output docs/videos/find-example.mp4
Output docs/videos/find-example.gif
Source tapes/settings.tape
Source tapes/prelude.tape

Type 'playground find-example "oracle cdc ssl" --limit 3'
Sleep 500ms
Enter
Sleep 4s
Type 'playground find-example "s3 sink" --category ccloud --limit 2'
Sleep 500ms
Enter
Sleep 4s
Type "# then run it with any CP and connector version:"
Enter
Type "playground run -f connect/connect-cdc-oracle19-source/cdc-oracle19-cdb-table-ssl.sh --tag 8.3.2 --connector-tag 2.15.2"
Sleep 5s
