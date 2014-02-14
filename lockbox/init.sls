# Turn off the SSH service
ssh:
  service:
    - dead
    - enable: False

# Purge the package
purge-ssh:
  pkg:
    - purged
    - names: 
      - openssh-server
