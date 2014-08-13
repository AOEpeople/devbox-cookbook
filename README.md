Devbox Cookbook
===============
Simple cookbook that prepare a server for Magento instances by

- creating folder structure (release folders, shared folders, symlinks)
- create databases
- creating Apache configuration (vhosts)
- creating systemstorage

The configuration of the Magento instances is done via databags:

Example:
--------

```javascript
{
    "id": "myproject_devbox",
    "project": "myproject",
    "environment": "devbox",
    "server_name": "www.myproject.com",
    "server_aliases": [ "backend.myproject.com" ],
    "databases": [ "myproject_devbox", "myproject_devbox_test" ],
    "prepare_systemstorages": [ "latest", "production", "staging"]
}

```

