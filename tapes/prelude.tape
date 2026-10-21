# shared prelude, sourced by every tape after tapes/settings.tape (not a clip itself)
# off camera: the clone (KDP_DIR, a neutral path like /Users/Shared/kafka-docker-playground), playground on the
# PATH, a no-op 'open' so that the HTML reports are not opened in a browser, a short prompt, no job control (its
# 'child setpgid' errors would show in the clips)
# The shell of the vhs terminal starts with SIGPIPE ignored, and bash cannot reset a signal ignored on entry: re-exec
# it through perl with SIGPIPE back to its default, or 'tr ... < /dev/urandom | head -c N' never ends and awk fails
# with 'write error on /dev/stdout' (playground topic produce hangs, --record-size never ends)
Hide
Type "exec perl -e '$SIG{PIPE} = q(DEFAULT); exec q(/bin/bash), q(--noprofile), q(--norc)'"
Enter
Sleep 1s
Type 'set +m && cd "$KDP_DIR" && export PATH="$VHS_BIN_DIR:$KDP_DIR/scripts/cli:$PATH" && export PS1="\[\e[1;36m\]❯\[\e[0m\] " && clear'
Enter
Sleep 1s
Show
