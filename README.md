# ISP-Bypass-Android

A robust, always-on SOCKS5 proxy tunnel designed to bypass ISP blocks and Tailscale routing restrictions directly from a rooted Android device.

## Overview
This project turns a Termux installation on an Android device into an enterprise-grade SSH dynamic port forwarding tunnel. It bridges traffic through Tailscale, allowing external devices to bypass local ISP restrictions and securely access resources that are normally strictly limited to your home Wi-Fi network.

**Core Use Case:** If your home ISP provides exclusive access to private FTP servers (e.g. BDIX FTPs) or private streaming sites (e.g. `dflix.live`), you can use this proxy to access those exact same sites from anywhere in the world, on any mobile network, as if you were sitting on your home couch.

## Features
- **ISP FTP Bypass:** Seamlessly access restricted, private-ISP-only FTP servers and local streaming sites remotely from outside networks.
- **SOCKS5 SSH Tunnel:** Uses native `sshd` to create a lightning-fast, secure tunnel.
- **Home Screen Toggle:** Integrates with `Termux:Widget` for one-tap toggling directly from the Android home screen.
- **Auto-Boot:** Integrates with `Termux:Boot` to silently start the proxy whenever the device reboots.
- **Zero-Mess Architecture:** Leaves Android's core networking intact—bypasses strict Seccomp/W^X kernel memory protections by relying on proven native SSH protocols.

## Installation

### Prerequisites
1. An Android device with [Termux](https://f-droid.org/en/packages/com.termux/) installed.
2. [Termux:Widget](https://f-droid.org/en/packages/com.termux.widget/) installed for home screen toggles.
3. [Termux:Boot](https://f-droid.org/en/packages/com.termux.boot/) installed for auto-start on reboot.
4. [Tailscale](https://tailscale.com/) active on the device.

### Setup
1. Clone this repository into your Termux home directory:
   ```bash
   git clone https://github.com/Imtiaz-Official/ISP-Bypass-Android.git ~/Proxy-Scripts
   ```
2. Run the automatic installer:
   ```bash
   cd ~/Proxy-Scripts
   chmod +x install.sh
   ./install.sh
   ```

## Usage

### On the Host (Home) Phone
1. Open the Tailscale app on this phone and copy its `100.x.x.x` IP address.
2. Tap the `Toggle-Proxy.sh` icon on your Android home screen via the Termux:Widget to start the proxy.
*(Note: The proxy will automatically start silently in the background thanks to Termux:Boot whenever your phone restarts).*

### On the Client (Outside) Phone
To route traffic through the tunnel, use an app that supports custom SOCKS5 proxies while Tailscale is active (e.g., **Nekobox**, **Firefox**, or **Kiwi Browser** with SwitchyOmega).

**Using Nekobox (Recommended for System-Wide/Brave Support):**
1. Add a new SOCKS5 profile with the proxy details below.
2. **CRITICAL:** Go into Nekobox Settings and change the routing mode from **VPN** (default) to **Proxy**. Android only allows one active VPN at a time, so if Nekobox runs as a VPN, it will disconnect Tailscale!
3. Start the proxy in Nekobox.

**Proxy Details:**
- **IP:** `<Your-Home-Phone-Tailscale-IP>` (e.g. `100.x.x.x`)
- **Port:** `1080`
- **Type:** SOCKS5 (with Remote DNS enabled)

## Why not just use Tailscale Exit Nodes?
Tailscale's Android client strictly forbids routing private IPs (like `172.16.x.x`) through an Exit Node. This setup wraps *all* traffic (public and private) into a SOCKS5 tunnel, bypassing Tailscale's limitations completely.
