# 🔐 Credentials an example needs: check what is missing, store it once
Output docs/videos/secrets.mp4
Source tapes/settings.tape
Source tapes/prelude.tape

Type "playground secrets check -f connect/connect-zendesk-source/zendesk-source-organizations.sh"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 3s
Type "playground secrets set ZENDESK_URL"
Sleep 500ms
Enter
Sleep 2s
Type "https://example.zendesk.com"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 2s
Type "playground secrets check -f connect/connect-zendesk-source/zendesk-source-organizations.sh"
Sleep 500ms
Enter
Wait /❯\s*$/
Sleep 5s
