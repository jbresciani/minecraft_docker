#!/bin/sh
set -x
if [ ! -f "${MINECRAFT_HOME}" ]; then
  mkdir -p "${MINECRAFT_HOME}"
fi

if [ ! -f "${MINECRAFT_LOGS}" ]; then
  mkdir -p "${MINECRAFT_LOGS}"
fi

if [ -z "${ALLOW-FLIGHT}" ]; then
  sed -i s/^allow-flight=.*/allow-flight=${ALLOW-FLIGHT}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${DIFFICULTY}" ]; then
  sed -i s/^difficulty=.*/difficulty=${DIFFICULTY}/g "${MINECRAFT_HOME}/server.properties"
# 0 - Peaceful
# 1 - Easy
# 2 - Normal
# 3 - Hard
fi

if [ -z "${GAMEMODE}" ]; then
  sed -i s/^gamemode=.*/gamemode=${GAMEMODE}/g "${MINECRAFT_HOME}/server.properties"
# 0 - Survival
# 1 - Creative
# 2 - Adventure
# 3 - Spectator
fi

if [ -z "${GENERATE-STRUCTURES}" ]; then
  sed -i s/^generate-structures=.*/generate-structures=${GENERATE-STRUCTURES}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${HARDCORE}" ]; then
  sed -i s/^hardcore=.*/hardcore=${HARDCORE}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${LEVEL-TYPE}" ]; then
  sed -i s/^level-type=.*/level-type=${LEVEL-TYPE}/g "${MINECRAFT_HOME}/server.properties"
# DEFAULT - Standard world with hills, valleys, water, etc.
# FLAT - A flat world with no features, can be modified with generator-settings.
# LARGEBIOMES - Same as default but all biomes are larger.
# AMPLIFIED - Same as default but world-generation height limit is increased.
# BUFFET - Same as default unless generator-settings is set to a preset.
fi

if [ -z "${LEVEL-SEED}" ]; then
  sed -i s/^level-seed=.*/level-seed=${LEVEL-SEED}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${MAX-PLAYERS}" ]; then
  sed -i s/^max-players=.*/max-players=${MAX-PLAYERS}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${MOTD}" ]; then
  sed -i s/^motd=.*/motd=${MOTD}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${PVP}" ]; then
  sed -i s/^pvp=.*/pvp=${PVP}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${SPAWN-ANIMALS}" ]; then
  sed -i s/^spawn-animals=.*/spawn-animals=${SPAWN-ANIMALS}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${SPAWN-MONSTERS}" ]; then
  sed -i s/^spawn-monsters=.*/spawn-monsters=${SPAWN-MONSTERS}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${SPAWN-NPCS}" ]; then
  sed -i s/^spawn-npcs=.*/spawn-npcs=${SPAWN-NPCS}/g "${MINECRAFT_HOME}/server.properties"
fi

if [ -z "${SPAWN-PROTECTION}" ]; then
  sed -i s/^spawn-protection=.*/spawn-protection=${SPAWN-PROTECTION}/g "${MINECRAFT_HOME}/server.properties"
fi

echo eula=${ACCEPT_EULA} > ${MINECRAFT_HOME}/eula.txt

/usr/bin/java \
    ${JAVA_OPTS} \
    -jar ${MINECRAFT_HOME}/minecraft_server.jar \
    nogui # 1>> ${MINECRAFT_LOGS}/minecraft.out 2>> ${MINECRAFT_LOGS}/minecraft.err
