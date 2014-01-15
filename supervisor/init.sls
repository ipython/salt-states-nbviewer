supervisor_install:
    pkg.installed:
        - name: supervisor

supervisor:
    service:
        - running
        - enable: True
        - reload
        - watch:
          - pkg: supervisor
