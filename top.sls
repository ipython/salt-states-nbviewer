base:
  '*':
    # All boxes get python installed+memcache
    - python
    - memcache

# Production boxes
prod:
  'prod*':
    - nbviewer
    - supervisor
    - firewall

# QA/Testing boxes
qa:
  'qa*':
    - nbviewer
    - supervisor
    - firewall
