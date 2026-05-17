#!/bin/bash
# harden-network.sh - Strict egress filtering for Gemini CLI Sandboxes
# Inspired by libops/cli-sandbox
# Usage: sudo harden-network [on|off]

set -e

# Verify root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)."
   exit 1
fi

# Check for iptables availability
if ! command -v iptables &> /dev/null; then
    echo "iptables not found. Installing..."
    apt-get update && apt-get install -y iptables
fi

case "$1" in
    on)
        echo "Applying strict network egress rules..."

        # 1. Flush existing rules
        iptables -F
        iptables -X

        # 2. Allow established and related connections (return traffic)
        iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

        # 3. Allow Loopback (internal comms)
        iptables -A OUTPUT -o lo -j ACCEPT

        # 4. Allow Essential Infrastructure (DNS)
        iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

        # 5. Allow Official AI APIs & Version Control
        # Note: In a production container, you'd ideally resolve these to specific IPs.
        # This implementation provides the framework for domain-based filtering if using a proxy,
        # but for native iptables, we allow standard ports for common dev domains.
        
        echo "Allowing HTTP/HTTPS to common development domains..."
        iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

        # 6. Default Deny for everything else
        # To make it truly 'libops' grade, you would block 80/443 and only allow specific IPs.
        # However, for a polyglot dev environment, we default to allowing standard web traffic
        # but blocking all non-standard ports (exfiltration ports).
        iptables -P OUTPUT DROP
        
        echo "Network hardened. Only standard web traffic (80/443) and DNS (53) are permitted."
        echo "Note: Requires --cap-add=NET_ADMIN to function."
        ;;
    off)
        echo "Disabling strict network egress rules..."
        iptables -P OUTPUT ACCEPT
        iptables -F
        echo "Network restrictions removed."
        ;;
    *)
        echo "Usage: $0 [on|off]"
        exit 1
        ;;
esac
