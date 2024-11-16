# TiltedEvolution-Docker
This repository contains custom Docker images for the [Tilted Evolution](https://github.com/tiltedphoques/TiltedEvolution) / [Skyrim Together Reborn](https://skyrim-together.com/) project using a base of Alpine and Debian. There is also a Docker image and Pterodactyl egg for easily running the game server using [Pterodactyl](https://pterodactyl.io/).

I am not affiliated with the Tilted Evolution or Pterodactyl development teams, projects, or any other related teams or pojects.

> [!IMPORTANT]  
> Current Supported Platforms  
> - alpine:  
>   - builder: amd64, arm64, arm/v7  
>   - server/pterodactyl: amd64  
>  
> - debian:  
>   - builder: amd64, arm64, arm/v7  
>   - server/pterodactyl: amd64, arm64  

> [!WARNING]  
> There are currently issues with newer version of Alpine and building for glibc.  
> On top of that, there are also issues alpine and the latest TiltedEvolution build for arm.  
> This may require switching to a different container based image, such as Debian.  

## Images
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
