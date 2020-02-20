#!/bin/bash
set -m
/usr/sbin/rtpengine -f -E -L 7 --no-log-timestamps \
    --pidfile /run/ngcp-rtpengine-daemon.pid \
    --config-file /etc/rtpengine/rtpengine.conf &

/usr/sbin/rtpengine-recording --config-file=/etc/rtpengine/rtpengine-recording.conf

fg %1
