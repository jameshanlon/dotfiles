# Server notes

## Security

- Change SSH port (`Port`) in `/etc/ssh/sshd_config`

  ```
  $ sudo service ssh restart
  ```

- Restrict SSH ip addresses in `/etc/hosts.allow`

- sSMTP as MTA for notifications: https://wiki.debian.org/sSMTP.

  ```
  $ sudo apt-get install mailutils ssmtp
  $ cat /etc/ssmtp/ssmtp.conf # Config file
  $ sudo rm -rf /usr/sbin/ sendmail # Use instead of sendmail for Fail2Ban
  $ sudo ln -s /usr/sbin/ssmtp /usr/sbin/sendmail
  ```

- Fail2Ban for blocking repeated failed access attempts.

  ```
  $ sudo apt-get install fail2ban
  $ sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
  $ sudo cat /etc/fail2ban/jail.local # Customise configuration
  $ sudo fail2ban {start, status, reload}
  $ sudo cat /var/log/fail2ban.log
  $ sudo iptables -L # Check the IP tables for Fail2Ban rules
  ```

  See (http://www.doc.ic.ac.uk/~pg1712/blog/fail2ban-in-ubuntu/

- Check active network connections.
  ```
  $ sudo netstat -plunt
  ```

## References

- https://www.digitalocean.com/community/tutorials/7-security-measures-to-protect-your-servers
