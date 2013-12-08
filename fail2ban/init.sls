fail2ban-pkg:
  pkg.installed:
    - name: fail2ban

fail2ban-config:
  fail2ban_file:
    - managed
    - name: /etc/fail2ban/fail2ban.conf
    - source: salt://fail2ban/fail2ban.conf
    - require:
      - pkg: fail2ban
  jail_file:
    - managed
    - name: /etc/fail2ban/jail.conf
    - source: salt://fail2ban/jail.conf
    - require:
      - pkg: fail2ban
