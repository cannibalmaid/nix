#!/usr/bin/env sh

while true; do
    cat << EOF
[ \
    { \
        "application_id": 1042312946975526922, \
        "state": "$(uname -r)", \
        "details": "$(uname -n)", \
        "large_image": { \
            "key": "https://i.pinimg.com/originals/96/ae/47/96ae47fb64b2030f8384225220c91dce.gif", \
            "text": null \
        }, \
        "small_image": { \
            "key": "https://c.tenor.com/TgKK6YKNkm0AAAAi/verified-verificado.gif", \
            "text": null \
        }, \
        "start_timestamp": null, \
        "end_timestamp": null, \
        "buttons": [ \
            { \
                "label": "website", \
                "url": "https://example.com/" \
            } \
        ] \
    } \
]
EOF

    sleep 10

    pids="$(pidof code) $(pidof wineserver)" # for example; you can put your own processes here

    if [ "${#pids}" != 0 ]; then
        echo "[]"

        for pid in $pids; do
            if [ -d "/proc/$pid" ]; then # if process haven't exited yet
                tail --pid=$pid -f /dev/null # wait for process to exit
            fi
        done
    fi
done
