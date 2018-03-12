# Server notes

## Security

- Change SSH port (`Port`) in `/etc/ssh/sshd_config`, then
  ```
  $ sudo service ssh restart
  ```

- Whitelist SSH ip addresses in `/etc/hosts.allow`.

- sSMTP as MTA for notifications: https://wiki.debian.org/sSMTP.
  ```
  $ sudo apt-get install mailutils ssmtp
  $ cat /etc/ssmtp/ssmtp.conf # Config file
  $ sudo rm -rf /usr/sbin/ sendmail # Use instead of sendmail for Fail2Ban
  $ sudo ln -s /usr/sbin/ssmtp /usr/sbin/sendmail
  ```
  Test it:
  ```
  $ echo "Blah" | sendmail -s "This is a test sSMTP email" mail@domain.com
  ```

- Fail2Ban for blocking repeated failed access attempts. As root:
  ```
  $ sudo apt-get install fail2ban
  $ sudo cp fail2ban/jail.local /etc/fail2ban/
  $ sudo cp fail2ban/sendmail-common.local /etc/fail2ban/action.d
  $ fail2ban reload       # Reload configuration
  $ fail2ban {-d, -vvd}   # Display loaded configuration
  $ fail2ban {start, stop}
  ```
  Various diagnostics:
  ```
  $ fail2ban status            # Display jail status
  $ cat /var/log/fail2ban.log  # The logfile
  $ iptables -L                # Check the IP tables for Fail2Ban rules
  $ service fail2ban status    # Check the service status
  ```

  See also
    * http://www.doc.ic.ac.uk/~pg1712/blog/fail2ban-in-ubuntu/
    * https://github.com/fail2ban/fail2ban/wiki/Proper-fail2ban-configuration
    * https://www.linode.com/docs/security/using-fail2ban-for-security/ 

- Check active network connections.
  ```
  $ sudo netstat -plunt
  ```

## References

- https://www.digitalocean.com/community/tutorials/7-security-measures-to-protect-your-servers
