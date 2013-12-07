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
      - libcurl4-openssl-dev

# Pull down the current codebase of nbviewer from github, unless pillar has something else for us
nbviewer-git:
  git.latest:
    - name: {{ salt['pillar.get']('nbviewer:location', 'https://github.com/ipython/nbviewer.git') }}
    - rev: {{ salt['pillar.get']('nbviewer:rev', 'master') }}
    - target: /usr/share/nbviewer
    - force: true
    - require:
      - pkg: git

# Install all the dependencies for nbviewer via its requirements.txt into a virtualenv
/usr/share/nbviewer/venv:
    virtualenv.manage:
        - requirements: /usr/share/nbviewer/requirements.txt
        - clear: false
