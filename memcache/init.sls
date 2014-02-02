# Handle naming differences for current production boxes, future boxes,
# Travis CI.

{% if grains['os'] == 'Ubuntu' %}
  {% if grains['osrelease'] in ['12.10', '13.04', '13.10'] %}
    {% set libmemcached = "libmemcached10" %}
  {% else %} # grains['osrelease'] == '12.04' %}
    {% set libmemcached = "libmemcached6" %}
  {% endif %}
{% else %}
    # Default to libmemcached6 otherwise
    {% set libmemcached = "libmemcached6" %}
{% endif %}

memcached:
    pkg.installed:
        - names:
          - memcached
          - libmemcached-dev
          - libmemcache-dev
          - {{ libmemcached }}
          - zlib1g-dev
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
