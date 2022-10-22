# TiltedEvolution-Docker
This repository contains custom Docker images for the Tilted Evolution / Skyrim Together Reborn project using a base of Alpine Linux. There is also a Docker image and Pterodactyl egg for easily running the game server using [Pterodactyl](https://pterodactyl.io/).

I am not affiliated with the Tilted Evolution development team, project, or any other related teams or pojects.

## Building
  * `docker build -t tiltedevolution-builder:latest -f Dockerfile.builder .`
  * `docker build -t tiltedevolution-server:latest -f Dockerfile .`
  * `docker build -t tiltedevolution-pterodactyl:latest -f Dockerfile.pterodactyl .`


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