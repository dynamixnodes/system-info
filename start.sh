#!/bin/bash

clear

echo "==============================================="
echo "     VPS SYSTEM INFO - DYNAMIXNODES"
echo "==============================================="
echo

# Hostname
echo "🖥️  Hostname        : $(hostname)"

# OS
OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
echo "🐧 OS              : $OS_NAME"

# Kernel
echo "🔧 Kernel          : $(uname -r)"

# Uptime
echo "⏱️  Uptime          : $(uptime -p)"

# CPU Info
CPU_MODEL=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
CPU_CORES=$(nproc)
echo "🧠 CPU Processer   : $CPU_MODEL"
echo "⚡ CPU Cores       : $CPU_CORES vCores"

# RAM
RAM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
RAM_USED=$(free -h | awk '/Mem:/ {print $3}')
echo "🟩 RAM             : $RAM_USED / $RAM_TOTAL"

# Disk
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
echo "💾 Disk            : $DISK_USED / $DISK_TOTAL"

# Virtualization
VIRT=$(systemd-detect-virt)
echo "🧱 Virtualization  : $VIRT"

# Public IP
PUBLIC_IP=$(curl -s ifconfig.me)
echo "🌍 Public IP       : $PUBLIC_IP"

# Location & ISP
LOCATION=$(curl -s ipinfo.io/country)
ISP=$(curl -s ipinfo.io/org)
echo "📍 Location        : $LOCATION"
echo "🏢 ISP             : $ISP"

echo
echo "=================================================="
echo

# Exit prompt
read -p "➡️  Press ENTER to exit..."
