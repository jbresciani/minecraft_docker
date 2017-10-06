Minecraft
===

Building the container
---
Executing

```
./build.sh
```

will build out a docker container with the name:tag of minecraft:1.12.2, BUT this will not publish your image to gcr.io

You can override the minecraft server version downloaded with -v,
```
./build.sh -v 1.12.2
```
the version needs to match a valid official minecraft version

Using the container
---
To start the container run

```
docker run -d -p 25565:25565 --name minecraft minecraft-server:1.12.2
```

This will create an image with the name minecraft and start a minecraft server.

the config of the server can be altered by editing the server config file in the container in /home/minecraft/server

the startup memory can be altered by adjusting xmx and xms in /home/minecraft/server/minecraft-start.sh
# minecraft_docker
