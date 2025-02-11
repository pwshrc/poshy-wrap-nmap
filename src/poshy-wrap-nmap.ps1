#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
#Requires -Modules @{ ModuleName = "poshy-lucidity"; RequiredVersion = "0.4.1" }


# Some useful nmap aliases for scan modes

# Nmap options are:
#  -sS - TCP SYN scan
#  -v - verbose
#  -T1 - timing of scan. Options are paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5)
#  -sF - FIN scan (can sneak through non-stateful firewalls)
#  -PE - ICMP echo discovery probe
#  -PP - timestamp discovery probe
#  -PY - SCTP init ping
#  -g - use given number as source port
#  -A - enable OS detection, version detection, script scanning, and traceroute (aggressive)
#  -O - enable OS detection
#  -sA - TCP ACK scan
#  -F - fast scan
#  --script=vuln - also access vulnerabilities in target

function nmap_open_ports {
    nmap --open @params
}
function nmap_list_interfaces {
    nmap --iflist @params
}
function nmap_slow {
    sudo nmap -sS -v -T1 @params
}
function nmap_fin {
    sudo nmap -sF -v @params
}
function nmap_full {
    sudo nmap -sS -T4 -PE -PP "-PS80,443" -PY -g 53 -A "-p1-65535" -v @params
}
function nmap_check_for_firewall {
    sudo nmap -sA "-p1-65535" -v -T4 @params
}
function nmap_ping_through_firewall {
    nmap -PS -PA @params
}
function nmap_fast {
    nmap -F -T5 --version-light --top-ports 300 @params
}
function nmap_detect_versions {
    sudo nmap -sV "-p1-65535" -O --osscan-guess -T4 -Pn @params
}
function nmap_check_for_vulns {
    nmap --script=vuln @params
}
function nmap_full_udp {
    sudo nmap -sS -sU -T4 -A -v -PE "-PS22,25,80" "-PA21,23,80,443,3389" @params
}
function nmap_traceroute {
    sudo nmap -sP -PE "-PS22,25,80" "-PA21,23,80,3389" -PU -PO --traceroute @params
}
function nmap_full_with_scripts {
    sudo nmap -sS -sU -T4 -A -v -PE -PP "-PS21,22,23,25,80,113,31339" "-PA80,113,443,10042" -PO --script all
}
function nmap_web_safe_osscan {
    sudo nmap -p "80,443" -O -v --osscan-guess --fuzzy @params
}
function nmap_ping_scan {
    nmap -n -sP @params
}
