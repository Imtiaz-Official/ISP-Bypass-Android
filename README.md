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
2. **Via Widget (Recommended):** Tap the `Toggle-Proxy.sh` icon on your Android home screen via the Termux:Widget to start the proxy.
3. **Via Terminal (Manual):** If you prefer using the terminal directly, you can control the proxy manually:
   - **To toggle on/off:** Run `bash ~/Proxy-Scripts/Toggle-Proxy.sh`
   - **To forcefully start:** Run `bash ~/Proxy-Scripts/start-proxy.sh` (This is also the script `Termux:Boot` runs automatically in the background when your phone restarts).

### On the Client (Outside) Phone

#### Step 1: Tailscale Exit Node Setup (Optional but Recommended)
To route your normal public internet traffic through your home ISP as well:
1. On your **Host Phone**, open the Tailscale app, tap the three dots (menu), and select **Run as exit node**.
2. On your **Client Phone**, open Tailscale, tap your Host Phone's name, and select **Use exit node**.

#### Step 2: Route Traffic through the SOCKS5 Proxy
To access private ISP websites (which the Exit Node blocks), you must route traffic through the tunnel. You can do this system-wide (via Nekobox) or directly in a browser.

**Option A: Using Nekobox (System-Wide Support):**
1. Add a new SOCKS5 profile with the proxy details below.
2. **CRITICAL:** Go into Nekobox Settings and change the routing mode from **VPN** (default) to **Proxy**. Android only allows one active VPN at a time, so if Nekobox runs as a VPN, it will disconnect Tailscale!
3. Start the proxy in Nekobox.

**Option B: Using Firefox (Browser-Only):**
1. Open Firefox for Android.
2. Type `about:config` in the address bar.
3. Search for `network.proxy.socks` and enter your `<Your-Home-Phone-Tailscale-IP>`.
4. Search for `network.proxy.socks_port` and enter `1080`.
5. Search for `network.proxy.type` and change it to `1` (Manual proxy).
6. Search for `network.proxy.socks_remote_dns` and set it to `true`.

**Option C: Using Kiwi Browser (Browser-Only):**
1. Install **Kiwi Browser** from the Play Store.
2. Install the **Proxy SwitchyOmega** extension from the Chrome Web Store.
3. Create a new profile in SwitchyOmega.
4. Set the Protocol to `SOCKS5`, Server to `<Your-Home-Phone-Tailscale-IP>`, and Port to `1080`.
5. Apply the profile and activate it.

**Proxy Details Reference:**
- **IP:** `<Your-Home-Phone-Tailscale-IP>` (e.g. `100.x.x.x`)
- **Port:** `1080`
- **Type:** SOCKS5 (with Remote DNS enabled)

## Why not just use Tailscale Exit Nodes?
Tailscale's Android client strictly forbids routing private IPs (like `172.16.x.x`) through an Exit Node. This setup wraps *all* traffic (public and private) into a SOCKS5 tunnel, bypassing Tailscale's limitations completely.
