# VPN setup

Download opvn configuration from Synology.

## OSX using OpenVPN client

https://kb.synology.com/en-af/DSM/help/VPNCenter/vpn_setup?version=7

Disable compression.

Set cipher to AES-256-GCM

In exported VPNConfig.ovpn

Change 'tls-client' to 'client'.

Change 'cipher AES-256-CBC' to cipher AES-256-GCM'

Remove 'pull'

Uncomment 'float'

Change:

  verify-x509-name 'synology' name

To:

  verify-x509-name "synology" name

## iOS using OpenVPN client

https://kb.synology.com/en-af/DSM/tutorial/How_to_connect_VPN_server_from_iOS
