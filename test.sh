#!/bin/sh

request()
{
    printf '%b' \
        "normal\n" \
        "utilities-terminal\n" \
        "60\n" \
        "test\n" \
        "this is just a test"
}

case $1 in
    local)
        ( ./weechat-remote-notify.py 4444 & trap "kill $!" EXIT; read -p "press enter to stop"; )
    ;;
    nc)
        ( ./weechat-remote-notify.py 4444 & trap "kill $!" EXIT; sleep 1; netcat localhost 4444; )
    ;;
    request)
        (
            ./weechat-remote-notify.py 4444 & trap "kill $!" EXIT;
            sleep 1;
            request | nc -q1 localhost 4444;
            sleep 3;
        )
    ;;
    *)
        echo "use: local|nc|request"
esac
