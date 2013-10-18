base:
  '*':
    # All boxes get python installed+memcache
    - python
    - memcache
prod:
  'prod*':
    - nbviewer
    - supervisor
    - firewall
qa:
  'qa*':
    - nbviewer
    - supervisor
    - firewall
