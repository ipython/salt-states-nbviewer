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

# nbviewer binary dependencies
packages:
  pkg:
    - installed
    - names:
      - git
      - libzmq3-dev
      - pandoc
      - libevent-dev
      - libcurl4-openssl-dev
      - libmemcached-dev
      - {{ libmemcached }}
      - supervisor
      - nodejs

# Pull down the latest and greatest ipython, unless pillar has something else for us
ipython-git:
  git.latest:
    - name: {{ salt['pillar.get']('ipython:location', 'https://github.com/ipython/ipython.git') }}
    - rev: {{ salt['pillar.get']('ipython:rev', 'master') }}
    - target: /usr/share/ipython
    - force: true
    - force_checkout: true
    - require:
      - pkg: git

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

# Log the deploy, mostly for sanity
logdeploy:
  cmd.run:
    - name: "cd /usr/share/nbviewer && git log -1 --format='Deployed nbviewer %h %s' | logger"

# Install IPython + deps
/usr/share/nbviewer/venv:
    virtualenv.manage:
        - clear: false

ipython-pip:
  pip.installed:
    - name: -e /usr/share/ipython/[nbconvert]
    - bin_env: /usr/share/nbviewer/venv/

# Install all the dependencies for nbviewer via its requirements.txt into a virtualenv
/usr/share/nbviewer/venv:
    virtualenv.manage:
        - requirements: /usr/share/nbviewer/requirements.txt
        - clear: false
        - require:
          - pkg: libmemcached-dev

# nbviewer gets managed by supervisor
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

# Reread any configuration file changes
reread:
    cmd.run:
        - name: supervisorctl reread
        - watch:
            - file: /etc/supervisor/conf.d/nbviewer.conf

# Restart the process in case of code or environment variable updates
restart:
    cmd.run:
        - name: supervisorctl restart nbviewer

