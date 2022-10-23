# TiltedEvolution-Docker

[![Docker Hub](https://img.shields.io/badge/DockerHub-builder-blue?logo=docker&style=plastic)](https://hub.docker.com/r/ad3m3r5/tiltedevolution-builder)
[![Docker Hub](https://img.shields.io/badge/DockerHub-server-blue?logo=docker&style=plastic)](https://hub.docker.com/r/ad3m3r5/tiltedevolution-server)
[![Docker Hub](https://img.shields.io/badge/DockerHub-pterodactyl-blue?logo=docker&style=plastic)](https://hub.docker.com/r/ad3m3r5/tiltedevolution-pterodactyl)

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ad3m3r5/tiltedevolution-builder/latest?logo=docker&style=plastic)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ad3m3r5/tiltedevolution-server/latest?logo=docker&style=plastic)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ad3m3r5/tiltedevolution-pterodactyl/latest?logo=docker&style=plastic)

This repository contains custom Docker images for the Tilted Evolution / Skyrim Together Reborn project using a base of Alpine Linux. There is also a Docker image and Pterodactyl egg for easily running the game server using [Pterodactyl](https://pterodactyl.io/).

I am not affiliated with the Tilted Evolution development team, project, or any other related teams or pojects.

## Building
  * `docker build -t tiltedevolution-builder:latest -f Dockerfile.builder .`
  * `docker build -t tiltedevolution-server:latest -f Dockerfile .`
    * Dockerfile will default to the `master` branch. Specific tag versions can be used instead.
    * example: `docker build -t tiltedevolution-server:1.3.2 --build-arg BRANCH=v1.3.2 -f Dockerfile .`
  * `docker build -t tiltedevolution-pterodactyl:latest -f Dockerfile.pterodactyl .`
    * Dockerfile will default to `latest` tag of the `tiltedevolution-server` base image. Specific tag versions can be used instead.
    * example: `docker build -t tiltedevolution-pterodactyl:1.3.2 --build-arg VERSION=1.3.2 -f Dockerfile.pterodactyl .`


## Running
The original [wiki](https://wiki.tiltedphoques.com/tilted-online/guides/server-guide/linux-setup/docker-setup) information should still be used.


## Pterodactyl
This is for running a managed and containerized game server using [Pterodactyl](https://pterodactyl.io/). I am not affiliated with the Pterodactyl.io team in any way.

### Steps:
* Download the `egg-tilted-evolution.json` egg definition

* Adding the Nest & Egg
  * admin > Nests > **Create New**
    * Name: "Skyrim"
    * **Save**
  * admin > Nests > **Import Egg**
    * Egg File: `egg-tilted-evolution.json`
    * Associated Nest: "Skyrim"
    * **Import**

* Creating a Server
  * admin > "Servers" > **Create New**
    * Server Name: "Skyrim Together Reborn"
    * Server Owner: *desired user*
    * Memory: *desired memory allocation*
    * Disk: *desired disk space*
    * Nest: "Skyrim"
    * Egg: "Tilted Evolution"
    * **Create Server**

* Configuring the Server
  * Using the CLI:
    * Can be done while the server is running using the built in CLI commands.
    * This config will be saved to the `STServer.ini` file upon shutdown.
  * Using the `STServer.ini`:
    * Can ONLY be done while the server is shutdown
    * If done while running, the config will be overwritten with the running config

* Updating the Server
  * Pterodactyl should automatically pull the latest image when starting the server
