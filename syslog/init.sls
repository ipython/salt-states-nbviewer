rsyslog-gnutls:
    pkg.installed

/etc/rsyslog.d/nbviewer.conf:
    file.managed:
        - source: salt://syslog/nbviewer.conf.jinja
        - template: jinja
        - mode: 644
        - context:
            logentries_token: '{{ pillar['logentries']['token'] }}'

rsyslog:
    service:
        - running
        - enable: True
        - reload: True
        - watch:
            - file: /etc/rsyslog.d/nbviewer.conf
