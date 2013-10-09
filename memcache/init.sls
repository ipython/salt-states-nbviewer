memcached:
    pkg.installed:
        - names:
          - memcached
          - libmemcached-dev
          - libmemcache-dev
    file.managed:
        - name: /etc/memcached.conf
        - source: salt://memcache/memcached.conf
    service.running:
        - enable: true
        - watch: 
            - file: /etc/memcached.conf

python-memcache:
    pkg.installed:
        - name: python-memcache
    require:
        - pkg: memcached
