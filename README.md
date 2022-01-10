# Multi Docker Compose

Do you have multiple `docker-compose.yml` files you want to manage as isolated (or mixed, your call) environments?

Simply name your `compose` files as `docker-compose.envName.yml` and these scripts will help you manage them!

## Prerequisites

Of course, you need Docker and Docker Compose, and you'll need a handful of compose files!

> It's suggested you place the scripts in a folder that is accessible via the `$PATH` Environment Variable for ease of use.

## Running

All commands provided are described within the `dlist` script output.

A quality of life Environment Variable exists to statically locate config files: `COMPOSE_ENV_PATH`.

> Without the ENV var set, the scripts will assume the Current Working Directory to be the path to search for Compose Environments.


## Example Environment

I personally run my environment in a `envs-available` and `envs-enabled` setup, similar to the likes of `nginx` or other various system configuration include patterns.

For ease of use, I set `COMPOSE_ENV_PATH` to `/opt/compose/envs-enabled`, which houses the links pointing to the "available" environments, as well as the `.env*` file structure you use for ENV vars and secrets.

> Note the `.env` lives *in* the "enabled" folder, due to limitations on how `docker-compose` only allows/imports files at or below the config path [after v1.28](https://docs.docker.com/compose/env-file/). 

```
-rw-r--r--  1 nfg nfg  46 Jan  7 13:11 docker-compose.ark.yml -> ../envs-available/docker-compose.ark.yml
-rw-r--r--  1 nfg nfg  46 Jan  7 13:11 docker-compose.cloud-nfg.yml -> ../envs-available/docker-compose.cloud-nfg.yml
-rw-r--r--  1 nfg nfg  46 Jan  7 13:11 docker-compose.cloud-sync.yml -> ../envs-available/docker-compose.cloud-sync.yml
-rw-r--r--  1 nfg nfg  52 Jan  7 13:11 docker-compose.home-automation.yml -> ../envs-available/docker-compose.home-automation.yml
-rw-r--r--  1 nfg nfg  47 Jan  7 13:11 docker-compose.monitoring.yml -> ../envs-available/docker-compose.monitoring.yml
-rw-r--r--  1 nfg nfg  39 Jan  7 13:11 docker-compose.pz.yml -> ../envs-available/docker-compose.pz.yml
-rw-r--r--  1 nfg nfg  39 Jan  7 13:11 docker-compose.minecraft.yml -> ../envs-available/docker-compose.minecraft.yml
-rw-r--r--  1 nfg nfg  39 Jan  7 13:11 docker-compose.nas.yml -> ../envs-available/docker-compose.nas.yml
-rw-r--r--  1 nfg nfg  39 Jan  7 13:11 docker-compose.static-hosting.yml -> ../envs-available/docker-compose.static-hosting.yml
-rw-r--r--  1 nfg nfg  40 Jan  7 13:11 docker-compose.web.yml -> ../envs-available/docker-compose.web.yml
-rw-r--r--  1 nfg nfg  40 Jan  7 13:11 docker-compose.web-proxies.yml -> ../envs-available/docker-compose.web-proxies.yml
-rw-r--r--  1 nfg nfg  39 Jan  7 13:11 docker-compose.wordpress.yml -> ../envs-available/docker-compose.wordpress.yml
-rw-r--r--  1 nfg nfg  39 Jan  7 13:11 .env
```

Running a listing via `dlist` results in the following:

![alt text](./assets/dlist-demo.png)