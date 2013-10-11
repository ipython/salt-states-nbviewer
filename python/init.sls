# All the build essentials to install python with up to date setuptools, pip
packages:
  pkg:
    - installed
    - names:
      - build-essential
      - wget
      - curl
      - python-dev

# Install the most recent version of setuptools
setuptools:
  cmd.run:
    - name: wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python2.7

# Install the most recent version of pip, authoratively
pippin:
  cmd.run:
    - name: curl --show-error --retry 5 https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python2.7

python-packages:
  pip:
    - installed
    - names:
      - virtualenv
