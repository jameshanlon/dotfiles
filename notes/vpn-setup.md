# VPN setup

## OSX using OpenVPN client

In exported VPNConfig.ovpn, add:

  client-cert-not-required

Remove:

  pull

Change:

  verify-x509-name 'synology' name

To:

  verify-x509-name "synology" name
