#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo "🚀 ISP Bypass Android - Auto Installer"
echo "======================================"
echo ""

echo "[1/4] Installing necessary packages (OpenSSH)..."
pkg update -y
pkg install openssh -y

echo "[2/4] Setting up secure SSH keys for the background tunnel..."
mkdir -p ~/.ssh
if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q
    echo "✅ Generated new SSH key."
else
    echo "✅ SSH key already exists."
fi

# Ensure the key is authorized
if ! grep -q "$(cat ~/.ssh/id_ed25519.pub)" ~/.ssh/authorized_keys 2>/dev/null; then
    cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
    echo "✅ SSH key authorized."
else
    echo "✅ SSH key already authorized."
fi

echo "[3/4] Integrating with Termux system (Widgets & Boot)..."
mkdir -p ~/.shortcuts ~/.termux/boot
chmod +x ~/Proxy-Scripts/*.sh

echo 'bash ~/Proxy-Scripts/Toggle-Proxy.sh' > ~/.shortcuts/Toggle-Proxy.sh
echo 'bash ~/Proxy-Scripts/start-proxy.sh' > ~/.termux/boot/start-proxy.sh

chmod +x ~/.shortcuts/Toggle-Proxy.sh
chmod +x ~/.termux/boot/start-proxy.sh

echo "[4/4] Starting the SSH daemon securely..."
if ! pgrep sshd > /dev/null; then
    sshd
    echo "✅ SSH daemon started."
else
    echo "✅ SSH daemon already running."
fi

echo ""
echo "======================================"
echo "🎉 Setup Complete!"
echo "======================================"
echo "You can now add the Termux:Widget to your Android home screen"
echo "and tap 'Toggle-Proxy.sh' to start the tunnel!"
echo ""
echo "Make sure Tailscale is running, and find your 100.x.x.x IP"
echo "in the Tailscale app to connect your outside phone to port 1080."
