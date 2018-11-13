Minecraft
===

Building the container
---
Executing

```
./build.sh
```

will build out a docker container with the name:tag of minecraft:1.13.2

You can override the minecraft server version downloaded with -v,
```
./build.sh -v 1.13.2
```
The version needs to match a valid official minecraft version

Using the container
---
To start the container run

```
docker run -d -p 25565:25565 --name minecraft minecraft-server:1.13.2
```

This will create an image with the name minecraft and start a minecraft server.

the config of the server can be altered by editing the server config file in the container in /opt/minecraft

ENVIRONMENT VARIABLES
---

ACCEPT_EULA needs to be set to true to accept the EULA from Minecraft.
```
ACCEPT_EULA=false
```

To set Java values, adjust JAVA_OPTS, it defaults to the below
```
JAVA_OPTS="-Xmx2048m -Xms512m"
```

To control their corresponding server.properties values, the following can be adjusted:
```
ALLOW-FLIGHT=false
DIFFICULTY=1
GAMEMODE=0
GENERATE-STRUCTURES=true
HARDCORE=false
LEVEL-SEED=
LEVEL-TYPE=DEFAULT
MAX-PLAYERS=20
MOTD="A Minecraft Server"
PVP=true
SPAWN-ANIMALS=true
SPAWN-MONSTERS=true
SPAWN-NPCS=true
SPAWN-PROTECTION=16
```