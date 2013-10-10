packages:
  pkg:
    - installed
    - names:
      - build-essential
      - git
      - wget
      - curl
      - python-dev
      - libzmq-dev
      - sqlite3
      - libsqlite3-dev
      - python-pip
      - python-virtualenv
      - pandoc
      - libevent-dev

# Fix up pip weirdness via some package managers & upgrade pip
pippy:
  cmd.run:
    - name: wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python2.7
  cmd.run:
    - name: curl --show-error --retry 5 https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python2.7

nbviewer-git:
  git.latest:
    - name: https://github.com/ipython/nbviewer.git
    - rev: master
    - target: /usr/share/nbviewer
    - force: true
    - require:
      - pkg: git

/usr/share/nbviewer/venv:
    virtualenv.manage:
        - requirements: /usr/share/nbviewer/requirements.txt
        - clear: false
        - require:
            - pkg: python-virtualenv

