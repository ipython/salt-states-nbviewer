supervisor_install:
    pkg.installed:
        - name: supervisor

supervisor:
    service:
        - running
        - enable: True
