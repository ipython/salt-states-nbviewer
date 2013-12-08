fail2ban-pkg:
  pkg.installed:
    - name: fail2ban

/etc/fail2ban/fail2ban.conf:
  file.managed:
    - name: /etc/fail2ban/fail2ban.conf
    - source: salt://fail2ban/fail2ban.conf
    - require:
      - pkg: fail2ban

/etc/fail2ban/jail.conf:
  file.managed:
    - source: salt://fail2ban/jail.conf
    - require:
      - pkg: fail2ban
