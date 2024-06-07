# Linux - System informations via CLI

> "I'm using a Linux terminal and need to retrieve system information via the command line. Can you help?"

## One-line commands

| Command               | Description                                    |
| --------------------- | ---------------------------------------------- |
| `uname -a`            | System info                                    |
| `lsb_release -a`      | Linux Standard Base info                       |
| `hostname`            | System's hostname                              |
| `hostnamectl`         | Hostname details                               |
| `arch`                | System's architecture                          |
| `lscpu`               | CPU details                                    |
| `cat /proc/cpuinfo`   | CPU details                                    |
| `cat /proc/version`   | Kernel version                                 |
| `cat /proc/meminfo`   | Memory info                                    |
| `cat /proc/partitions`| Partition info                                 |
| `cat /proc/modules`   | Loaded kernel modules                          |
| `cat /etc/os-release` | OS release info                                |
| `cat /etc/issue`      | System identification text                     |
| `lshw`                | Hardware Lister                                |
| `lspci`               | PCI devices info                               |
| `lsusb`               | USB devices info                               |
| `lsmod`               | Loaded kernel modules                          |
| `lsblk`               | Block devices info                             |
| `sudo fdisk -l`       | Disk partitions list                           |
| `sudo hdparm /dev/sda`| Hard disk parameters                           |
| `df -h`               | Disk space usage                               |
| `blkid`               | Block device attributes                        |
| `mount \| column -t`  | Mounted filesystems                            |
| `free -h`             | Memory usage                                   |
| `netstat`             | Network connections                            |
| `netstat -i`          | Network interfaces status                      |
| `netstat -r`          | Routing table                                   |
| `ip link`             | Network interfaces info                        |
| `ip addr`             | Network addresses                              |
| `ip route`            | Routing table                                  |
| `dmesg`               | Kernel ring buffer messages                    |
| `top`                 | Task manager                                   |
| `htop`                | Interactive process viewer                     |
| `vmstat`              | System performance                             |
| `iostat`              | CPU & IO statistics                            |
| `sar`                 | System activity report                         |
| `uptime`              | System uptime and load                         |
| `who`                 | Users logged in                                |
| `w`                   | Users logged in and their activity             |
| `last`                | Login history                                  |
| `ps aux`              | Running processes                              |
| `pstree`              | Process tree                                   |
| `ss`                  | Socket statistics                              |
| `tcpdump`             | Network traffic analyzer                       |
| `dig`                 | DNS lookup                                     |
| `nslookup`            | DNS query                                      |
| `whois`               | Domain WHOIS information                       |
| `ping`                | Check network connectivity                     |
| `traceroute`          | Trace route to a network host                  |
| `mtr`                 | Network diagnostics tool                       |
| `lsof`                | List open files                                |
| `lsattr`              | List file attributes on a Linux second extended file system |
| `chattr`              | Change file attributes on a Linux second extended file system |
| `strace`              | Trace system calls and signals                 |
| `ltrace`              | Trace library calls                            |


## Simple script
```bash
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
```


## Other tools

Programs that shows a lot of detailed informations:

| Command               | Description                                   |
| --------------------- | --------------------------------------------- |
| `inxi`                | Command line system information script for console and IRC    |
| `hwinfo`              | Probe for hardware    |
| `sudo dmidecode -q`   | DMI table decoder     |
| `neofetch`            | CLI system information tool written in BASH    |

