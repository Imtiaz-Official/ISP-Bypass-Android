#!/data/data/com.termux/files/usr/bin/bash

# Check if the tunnel is already running
if pgrep -f "ssh -g -N -D 0.0.0.0:1080" > /dev/null; then
    # It's running, so kill it
    pkill -f "ssh -g -N -D 0.0.0.0:1080"
    termux-toast "🔴 SOCKS5 Proxy STOPPED"
else
    # It's not running, so start it
    termux-wake-lock
    nohup ssh -g -N -D 0.0.0.0:1080 -p 8022 -i ~/.ssh/id_ed25519 u0_a275@127.0.0.1 -o StrictHostKeyChecking=no > /dev/null 2>&1 &
    termux-toast "🟢 SOCKS5 Proxy STARTED"
fi
