# TiltedEvolution-Docker
This repository contains custom Docker images for the [Tilted Evolution](https://github.com/tiltedphoques/TiltedEvolution) / [Skyrim Together Reborn](https://skyrim-together.com/) project using a base of Alpine and Debian. There is also a Docker image and Pterodactyl egg for easily running the game server using [Pterodactyl](https://pterodactyl.io/).

I am not affiliated with the Tilted Evolution or Pterodactyl development teams, projects, or any other related teams or pojects.

> [!IMPORTANT]  
> Current Supported Platforms  
> - alpine:  
>   - builder: `amd64`, `arm64`, `arm/v7`, `arm/v6`  
>   - server/pterodactyl: `amd64`, `arm64`  
>  
> - debian:  
>   - builder: `amd64`, `arm64`, `arm/v7`  
>   - server/pterodactyl: `amd64`, `arm64`  

> [!WARNING]  
> There are issues building `crashpad` in newer alpine version, hence replacing it with `inproc`.  
> I am not sure if this will cause unforseen issues, but it seems to at least let it build.  

## Images

Images starting with `1.6.8` should be available on Docker Hub and ghcr.io. They should also have the "newer" versioning under a uniform name of `tiltedevolution`.  

- Alpine
  - tiltedevolution
    - Tags:
      - `builder-latest`, `builder-<version-of-builder>`
      - `server-latest`, `server-<version-of-builder>`
      - `pterodactyl-latest`, `pterodactyl-<version-of-builder>`
  - tiltedevolution-builder
    - Tags: `latest`, `<version-of-builder>`
  - tiltedevolution-server
    - Tags: `latest`, `<version-of-tilted>`
  - tiltedevolution-pterodactyl
    - Tags: `latest`, `<version-of-tilted>`

<br />

- Debian
  - tiltedevolution
    - Tags:
      - `builder-latest-debian`, `builder-<version-of-builder>-debian`
      - `server-latest-debian`, `server-<version-of-builder>-debian`
      - `pterodactyl-latest-debian`, `pterodactyl-<version-of-builder>-debian`
  - tiltedevolution-builder
    - Tags: `latest-debian`, `<version-of-builder>-debian`
  - tiltedevolution-server
    - Tags: `latest-debian`, `<version-of-tilted>-debian`
  - tiltedevolution-pterodactyl
    - Tags: `latest-debian`, `<version-of-tilted>-debian`

<br />

- [![Docker Hub](https://img.shields.io/badge/DockerHub-builder-blue?logo=docker&style=plastic)](https://hub.docker.com/r/ad3m3r5/tiltedevolution) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ad3m3r5/tiltedevolution/builder-latest?logo=docker&style=plastic)
- [![Docker Hub](https://img.shields.io/badge/DockerHub-server-blue?logo=docker&style=plastic)](https://hub.docker.com/r/ad3m3r5/tiltedevolution) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ad3m3r5/tiltedevolution/server-latest?logo=docker&style=plastic)
- [![Docker Hub](https://img.shields.io/badge/DockerHub-pterodactyl-blue?logo=docker&style=plastic)](https://hub.docker.com/r/ad3m3r5/tiltedevolution) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/ad3m3r5/tiltedevolution/pterodactyl-latest?logo=docker&style=plastic)

## Building
  - `docker build -t tiltedevolution:builder -f Dockerfile.builder .`
  - `docker build -t tiltedevolution:server -f Dockerfile.server .`
    - Dockerfile will default to the `master` branch. Specific tag versions can be used instead.
    - example: `docker build -t tiltedevolution:server-1.6.8 --build-arg BRANCH=v1.6.8 -f Dockerfile .`
  - `docker build -t tiltedevolution:pterodactyl -f Dockerfile.pterodactyl .`
    - Dockerfile will default to `latest` tag of the `tiltedevolution` base image. Specific tag versions can be used instead.
    - example: `docker build -t tiltedevolution:pterodactyl-1.3.2 --build-arg VERSION=1.3.2 -f Dockerfile.pterodactyl .`


## Running
The original [wiki](https://wiki.tiltedphoques.com/tilted-online/guides/server-guide/linux-setup/docker-setup) information should still be used, but with the new image.  

Newer versions of this image do not run as root, so you will have to set the directory permissions as shown below.  

Example:
```
mkdir -p /opt/docker/skyrimserver/{config,logs,Data}
chown -R 1000:1000 /opt/docker/skyrimserver/

docker run -d -it --name skyrimserver -p 10578:10578/udp \
  -v /opt/docker/skyrimserver/config:/home/tilted/config \
  -v /opt/docker/skyrimserver/Data:/home/tilted/Data \
  -v /opt/docker/skyrimserver/logs:/home/tilted/logs \
  ad3m3r5/tiltedevolution:server
```

## Pterodactyl
This is for running a managed and containerized game server using [Pterodactyl](https://pterodactyl.io/).

### Steps:
- Download the desired egg `.json` file
  - alpine: `egg-tilted-evolution-alpine.json`
  - debian: `egg-tilted-evolution-debian.json`

- Adding the Nest & Egg
  - admin > Nests > **Create New**
    - Name: `Tilted Evolution`
      - You can choose a different name, like `Skyrim Together`
    - **Save**
  - admin > Nests > **Import Egg**
    - Egg File: `egg-tilted-evolution.json`
    - Associated Nest: `Tilted Evolution`
      - Or whichever name you chose above
    - **Import**

- Creating a Server
  - admin > "Servers" > **Create New**
    - Server Name: `Tilted Evolution Server`
    - Server Owner: *desired user*
    - Memory: *desired memory allocation*
    - Disk: *desired disk space*
    - Nest: `Tilted Evolution`
      - Or whichever name you chose above
    - Egg: `Tilted Evolution (X)`
      - Where `X` is `alpine` or `debian`
    - **Create Server**

- Configuring the Server
  - Using the CLI:
    - Can be done while the server is running using the built in CLI commands.
    - This config will be saved to the `STServer.ini` file upon shutdown.
  - Using the `STServer.ini`:
    - Can ONLY be done while the server is shutdown
    - If done while running, the config will be overwritten with the running config

- Updating the Server
  - Pterodactyl should automatically pull the latest image when (re)starting the server
