salt-nbviewer
=============

Salt States for [nbviewer](/ipython/nbviewer)

Simply installs nbviewer and its dependencies.

# Configuring the master

Setup the fileserver backend to use git, use this salt state.

```
fileserver_backend:
  - git

gitfs_remotes:
  - https://github.com/rgbkrk/salt-nbviewer.git
```
