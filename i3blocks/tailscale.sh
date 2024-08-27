#!/bin/bash

# Fetch Tailscale IP address
tailscale_ip=$(tailscale ip)

# Check if Tailscale IP is present
if [ -z "$tailscale_ip" ]; then
    echo "睊"  # Icon for disconnected or IP not found
else
    echo " $tailscale_ip"  # Icon for connected
fi

