#!/usr/bin/env bash

systemctl -q is-active dnscrypt-proxy.service || sudo systemctl start dnscrypt-proxy.service

tee /etc/resolv.conf > /dev/null << EOT
nameserver ::1
nameserver 127.0.0.1
options edns0 single-request-reopen
EOT
