#!/bin/sh

#### Begining of initialization

# Forbid all incoming connections
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP

# Forbid all outgoing connections
iptables -t filter -P OUTPUT DROP

# Flush existing rules
iptables -t filter -F
iptables -t filter -X

# Do not break existing connections
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

#### End of initialization

#### Begining of rules

# Allow loopback

iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT

# Allow ping (in & out)

iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

# Allow HTTP (in & out)

iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT

iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT

# Allow SSH (in & out)

iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 38170 -j ACCEPT

iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 38170 -j ACCEPT

# Allow SMTP (in & out)

iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 993 -j ACCEPT

iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 993 -j ACCEPT

#### End of rules
