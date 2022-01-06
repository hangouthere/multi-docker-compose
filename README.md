# Multi Docker Compose

Have multiple `docker-compose.yml` files you want to manage as isolated (or mixed, your call) environments?

Simply name your `compose` files as `docker-compose.envName.yml` and these scripts will help you manage them!

## Prerequisites

Of course, you need Docker, and Docker Compose, and you'll need a handful of compose files!

> It's suggested you place the scripts in a folder that is accessible via the `$PATH` Environment Variable for ease of use.

## Running

All commands provided are described within the `dlist` script output.

A quality of life Environment Variable exists to statically locate config files: `COMPOSE_ENV_PATH`.

Without the ENV var set, you will need to execute the scripts from the path where your enviroment configs exist.
