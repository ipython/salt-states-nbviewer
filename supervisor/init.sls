supervisor_install:
    pkg.installed:
        - name: supervisor

/etc/supervisor/conf.d/nbviewer.conf:
    file.managed:
        - source: salt://supervisor/nbviewer.conf.jinja
        - template: jinja
        - mode: 644
        - defaults:
            environment: 'HELLO="WORLD"'
        {% if pillar['supervisor']['environment'] != '' %}
        - context:
            environment: '{{ pillar['supervisor']['environment'] }}'
        {% endif %}

supervisor:
    service:
        - running
        - enable: True
        - reload: True
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

reread:
    cmd.run:
        - name: supervisorctl reread
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

update:
    cmd.run:
        - name: supervisorctl update
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

