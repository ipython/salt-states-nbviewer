supervisor_install:
    pip.installed:
        - name: supervisor
        - upgrade: True

supervisor:
    service:
        - running
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

/etc/supervisor/conf.d/nbviewer.conf:
    file.managed:
        - source: salt://supervisor/nbviewer.conf.jinja
        - template: jinja
        - mode: 644

updates:
    cmd.run:
        - name: supervisorctl reread
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf
    cmd.run:
        - name: supervisorctl update
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

