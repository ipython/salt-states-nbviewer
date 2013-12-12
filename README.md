salt-nbviewer
=============

Salt States for [nbviewer](http://github.com/ipython/nbviewer)

Simply installs nbviewer and its dependencies.

# Configuring the master

Make sure to install gitfs dependencies on the master first (and not fail silently).

```
$ apt-get install -y git python-pip
$ pip install gitpython
```

Setup the fileserver backend to use git and use this salt state. Simply add these lines to `/etc/salt/master`.

```
fileserver_backend:
  - git

gitfs_remotes:
  - https://github.com/rgbkrk/salt-nbviewer.git
```

If doing local development, set `gitfs_remotes` to the local clone:

```
fileserver_backend:
  - git

gitfs_remotes:
  - file:///code/salt-nbviewer
```

Alternatively, just pull it down to where you want to reference it.

```
fileserver_backend:
    - roots

file_roots:
    base:
        - /srv/salt/salt-nbviewer

```

You will probably need to restart the salt master after making these changes. `service salt-master restart`.

