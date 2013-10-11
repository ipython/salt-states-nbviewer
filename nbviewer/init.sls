# nbviewer binary dependencies
packages:
  pkg:
    - installed
    - names:
      - libzmq-dev
      - sqlite3
      - libsqlite3-dev
      - pandoc
      - libevent-dev

# Pull down the current codebase of nbviewer from github
nbviewer-git:
  git.latest:
    - name: https://github.com/ipython/nbviewer.git
    - rev: master
    - target: /usr/share/nbviewer
    - force: true
    - require:
      - pkg: git

# Install all the dependencies for nbviewer via its requirements.txt into a virtualenv
/usr/share/nbviewer/venv:
    virtualenv.manage:
        - requirements: /usr/share/nbviewer/requirements.txt
        - clear: false
        - require:
            - pkg: python-virtualenv

