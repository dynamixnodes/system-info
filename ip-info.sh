#!/bin/bash

echo ""
echo "==============================="
echo "🌐  IP INFO - RydenByte"
echo "==============================="
echo ""

# Get IPs
ipv4=$(curl -4 -s ifconfig.me)
ipv6=$(curl -6 -s ifconfig.me)

# Get location (using IPv4 mainly)
location=$(curl -s http://ip-api.com/json/$ipv4 | grep -oP '"city":"\K[^"]+')
country=$(curl -s http://ip-api.com/json/$ipv4 | grep -oP '"country":"\K[^"]+')

# Latency check
latency=$(ping -c 1 1.1.1.1 | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}')

echo "📡 IPv4 Section"
echo "--------------------------------"

if [[ -n "$ipv4" ]]; then
    echo "✅ Status : Yes"
    echo "🔢 Value  : $ipv4"

    if [[ $ipv4 =~ ^10\. || $ipv4 =~ ^192\.168\. || $ipv4 =~ ^172\.1[6-9]\. || $ipv4 =~ ^172\.2[0-9]\. || $ipv4 =~ ^172\.3[0-1]\. ]]; then
        echo "🏷️ Type   : Private"
    elif [[ $ipv4 =~ ^127\. ]]; then
        echo "🏠 Type   : Local"
    else
        echo "🌍 Type   : Public"
    fi
else
    echo "❌ Status : No"
    echo "🔢 Value  : None"
    echo "🏷️ Type   : None"
fi

echo ""
echo "🛰️ IPv6 Section"
echo "--------------------------------"

if [[ -n "$ipv6" ]]; then
    echo "✅ Status : Yes"
    echo "🔢 Value  : $ipv6"

    if [[ $ipv6 =~ ^fe80 ]]; then
        echo "🏠 Type   : Local"
    elif [[ $ipv6 =~ ^fc || $ipv6 =~ ^fd ]]; then
        echo "🏷️ Type   : Private"
    else
        echo "🌍 Type   : Public"
    fi
else
    echo "❌ Status : No"
    echo "🔢 Value  : None"
    echo "🏷️ Type   : None"
fi

echo ""
echo "📍 Location"
echo "--------------------------------"
if [[ -n "$location" ]]; then
    echo "🌆 City    : $location"
    echo "🌎 Country : $country"
else
    echo "❓ Unknown"
fi

echo ""
echo "⚡ Latency"
echo "--------------------------------"
if [[ -n "$latency" ]]; then
    echo "📶 Ping : ${latency} ms"
else
    echo "❌ Unable to measure"
fi
# check if speedtest-cli is installed
if command -v speedtest-cli >/dev/null 2>&1; then
    speedtest-cli --simple
else
    echo "❌ speedtest-cli not installed. Install it using: sudo apt install speedtest-cli"
fi

echo ""
echo "==============================="
read -p "Press Enter to close..."
