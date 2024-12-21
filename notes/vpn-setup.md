# VPN setup

Download opvn configuration from Synology.

## OSX using OpenVPN client

https://kb.synology.com/en-af/DSM/help/VPNCenter/vpn_setup?version=7

In exported VPNConfig.ovpn

Change 'tls-client' to 'client'.

Add:

  client-cert-not-required

Remove:

  pull

Change:

  verify-x509-name 'synology' name

To:

  verify-x509-name "synology" name

## iOS using OpenVPN client

https://kb.synology.com/en-af/DSM/tutorial/How_to_connect_VPN_server_from_iOS
