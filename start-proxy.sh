#!/data/data/com.termux/files/usr/bin/bash

# Give Tailscale and network time to initialize after a reboot
sleep 10
termux-wake-lock
# Start the SOCKS5 proxy tunnel
nohup ssh -g -N -D 0.0.0.0:1080 -p 8022 -i ~/.ssh/id_ed25519 u0_a275@127.0.0.1 -o StrictHostKeyChecking=no > /dev/null 2>&1 &
