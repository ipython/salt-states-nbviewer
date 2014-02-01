# All the build essentials to install python with up to date setuptools, pip
base-deps:
  pkg:
    - installed
    - names:
      - build-essential
      - wget
      - curl
      - python-dev
      - python-setuptools
      - python-pip

virtualenv:
  pip.installed:
    - reload_modules: true
  require:
    - cmd: pippin

