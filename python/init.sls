# All the build essentials to install python with up to date setuptools, pip
base-deps:
  pkg:
    - installed
    - names:
      - build-essential
      - wget
      - curl
      - python-dev

python-setuptools:
  pkg.installed

python-pip:
  pkg.installed
  require:
    - pkg: python-setuptools

virtualenv:
  pip.installed:
    - reload_modules: true
  require:
    - pkg: python-pip

