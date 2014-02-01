# nbviewer binary dependencies
packages:
  pkg:
    - installed
    - names:
      - git
      - libzmq-dev
      - sqlite3
      - libsqlite3-dev
      - pandoc
      - libevent-dev
      - libcurl4-gnutls-dev
      - libmemcached-dev
      - supervisor

# Pull down the current codebase of nbviewer from github, unless pillar has something else for us
nbviewer-git:
  git.latest:
    - name: {{ salt['pillar.get']('nbviewer:location', 'https://github.com/ipython/nbviewer.git') }}
    - rev: {{ salt['pillar.get']('nbviewer:rev', 'master') }}
    - target: /usr/share/nbviewer
    - force: true
    - force_checkout: true
    - require:
      - pkg: git

logdeploy:
  cmd.run:
    - name: "cd /usr/share/nbviewer && git log -1 --format='Deployed nbviewer %h %s' | logger"

# Install all the dependencies for nbviewer via its requirements.txt into a virtualenv
/usr/share/nbviewer/venv:
    virtualenv.manage:
        - requirements: /usr/share/nbviewer/requirements.txt
        - clear: false

nbviewer:
  supervisord:
    - running
    - require:
      - pkg: supervisor
    - watch:
      - file: /etc/supervisor/conf.d/nbviewer.conf

# Manage the service with nbviewer
/etc/supervisor/conf.d/nbviewer.conf:
    file.managed:
        - source: salt://supervisor/nbviewer.conf.jinja
        - template: jinja
        - mode: 644
        - context:
            environment: '{{ salt['pillar.get']('supervisor:environment', '')}}'
        - requires:
          - sls: supervisor

# Reread any configuration file changes
reread:
    cmd.run:
        - name: supervisorctl reread
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf
        - requires:
          - sls: supervisor

# Restart the process in case of code or environment variable updates
restart:
    cmd.run:
        - name: supervisorctl restart nbviewer

