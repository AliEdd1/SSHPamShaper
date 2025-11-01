#!/bin/bash
LOGFILE="/var/log/bandwidth_limit.log"

USERNAME="$PAM_USER"         # user from PAM
TARGET_USER="user"           # change this to whoever you want limited
IFACE="eth0"                 # change if needed

if [ "$PAM_TYPE" = "open_session" ]; then
    if [ "$USERNAME" = "$TARGET_USER" ]; then
        /sbin/tc qdisc add dev "$IFACE" root tbf rate 8mbit burst 1024kbit latency 400ms
        echo "$(date) - Applied 8mbit limit to $USERNAME" >> "$LOGFILE"
    fi

elif [ "$PAM_TYPE" = "close_session" ]; then
    if [ "$USERNAME" = "$TARGET_USER" ]; then
        /sbin/tc qdisc del dev "$IFACE" root
        echo "$(date) - Removed traffic shaping for $USERNAME" >> "$LOGFILE"
    fi
fi
