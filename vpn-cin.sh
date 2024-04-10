#!/bin/bash

sudo pacman -S networkmanager-l2tp strongswan --needed --noconfirm
sudo systemctl restart NetworkManager

name="CIn VPN"
gateway="vpn.cin.ufpe.br"
psk="CInVpnSharedKey"
esp="3des-sha1"
ike="3des-sha1-modp1024"

nmcli connection add con-name "$name" type vpn vpn-type l2tp autoconnect no

nmcli connection modify "$name" \
	vpn.data "gateway=vpn.cin.ufpe.br,
        	  ipsec-enabled=yes,
        	  ipsec-esp=$esp,
		  ipsec-ike=$ike,
        	  machine-auth-type=psk,
        	  mru=1400,
		  mtu=1400,
        	  password-flags=2,
        	  refuse-chap=yes,
		  refuse-eap=yes,
        	  refuse-pap=yes,
        	  user=$1,
        	  user-auth-type=password,
		  service-type=org.freedesktop.NetworkManager.l2tp" \
	vpn.secrets "ipsec-psk=$psk" \
	ipv4.method "auto" \
	ipv6.addr-gen-mode "default" \
	ipv6.method "auto" \

echo "CIn VPN Configured"
