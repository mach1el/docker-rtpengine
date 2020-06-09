#!/bin/bash
set -m

HOST_IP=$(ip route get 8.8.8.8 | head -n +1 | tr -s " " | cut -d " " -f 7)

sed -i "s/interface=localhost/interface=${HOST_IP}/g" /etc/rtpengine/rtpengine.conf
sed -i "s/listen-ng=localhost:2229/listen-ng=${HOST_IP}:2229/g" /etc/rtpengine/rtpengine.conf
sed -i "s/listen-tcp=localhost:60001/listen-tcp=${HOST_IP}:60001/g" /etc/rtpengine/rtpengine.conf

/usr/sbin/rtpengine -f -E -L 7 --no-log-timestamps \
    --pidfile /run/ngcp-rtpengine-daemon.pid \
    --config-file /etc/rtpengine/rtpengine.conf &

/usr/sbin/rtpengine-recording --config-file=/etc/rtpengine/rtpengine-recording.conf

fg %1
