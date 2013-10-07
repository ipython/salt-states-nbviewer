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

memcached:
    pkg.installed:
        - names:
          - memcached
          - libmemcached-dev
          - libmemcache-dev
    file.managed:
        - name: /etc/memcached.conf
        - source: salt://ipython/memcached.conf
    service.running:
        - enable: true
        - watch: 
            - file: /etc/memcached.conf

python-memcache:
    pkg.installed:
        - name: python-memcache
    require:
        - pkg: memcached


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

