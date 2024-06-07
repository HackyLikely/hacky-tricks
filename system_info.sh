#!/usr/bin/bash

# Function to print line separator
print_line() {
  printf "%21s\n" | tr ' ' ${1:-'-'}
}

# Function to print section headers (bold)
print_header() {
  echo -e "\n\e[1m$1\e[0m"
  print_line 
}

# Function to print key-value pairs
print_info() {
  printf "%-20s %s\n" "$1" ": $2"
}

print_header "System Information"
print_info "Hostname"           "$(hostname)"
print_info "Distribution ID"    "$(lsb_release -si)"
print_info "Distribution"       "$(lsb_release -sd)"
print_info "Code Name"          "$(lsb_release -sc)"
print_info "Kernel Release"     "$(uname -r)"
print_info "Kernel Version"     "$(uname -v)"
print_info "OS"                 "$(uname -o)"

print_header "Hostname Details"
hostnamectl

print_header "Users Information"
print_info "Whoami"             "$(whoami)"
print_info "Logged-in Users"    "$(who | awk '{print $1}' | sort -u | tr '\n' ', ')"
print_info "Date Now"           "$(date)"
print_info "Last system boot"   "$(who -b | awk '{print $(NF-1), $NF}')"
print_info "Uptime"             "$(uptime -p)"

print_header "CPU Information"
print_info "CPU Model" "$(lscpu | grep "Model name" | sed 's/Model name: *//')"
print_info "CPU Cores" "$(lscpu | grep "^CPU(s):" | awk '{print $2}')"
print_info "CPU Architecture" "$(lscpu | grep "Architecture" | awk '{print $2}')"

print_header "Memory Information"
free -h

print_header "Disk Information"
blkid
echo ""
df -h

print_header "Network Information"
ip -brief address
ip -brief link

print_header "Routing Table"
ip route | column -t