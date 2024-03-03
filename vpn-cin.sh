#!/bin/bash

sudo pacman -S networkmanager-l2tp strongswan --needed --noconfirm

name="CIn VPN"
gateway="vpn.cin.ufpe.br"
psk="CInVpnSharedKey"
ike="3des-sha1-modp1024"
esp="3des-sha1"

nmcli connection add con-name "$name" type vpn vpn-type l2tp

nmcli connection modify "$name" \
  vpn.data "gateway = vpn.cin.ufpe.br,
            ipsec-enabled = yes,
            ipsec-psk = $psk,
            ipsec-ike = $ike,
            ipsec-esp = $esp,
            machine-auth-type = psk,
            mru = 1400,
            mtu = 1400,
            password-flags = 1,
            refuse-chap = yes,
            refuse-eap = yes,
            refuse-pap = yes,
            require-mppe = yes,
            user = $1,
            user-auth-type = password" \

echo "CIn VPN Configured"
