# A minecraft server
FROM openjdk:jre

LABEL MAINTAINER Jacob Bresciani \
      VERSION: 1.0.2

ARG MINECRAFT_VERSION=${MINECRAFT_VERSION}

# Default to UTF-8 file.encoding
ENV ACCEPT_EULA=false \
    JAVA_OPTS="-Xmx2048m -Xms512m" \
    LANG=C.UTF-8 \
    MINECRAFT_HOME=/opt/minecraft \
    MINECRAFT_VERSION="${MINECRAFT_VERSION}" \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin \
    ALLOW_FLIGHT=false \
    DIFFICULTY=1 \
    GAMEMODE=0 \
    GENERATE_STRUCTURES=true \
    HARDCORE=false \
    LEVEL_SEED= \
    LEVEL_TYPE=DEFAULT \
    MAX_PLAYERS=20 \
    MOTD="A Minecraft Server in a Docker Container" \
    PVP=true \
    SPAWN_ANIMALS=true \
    SPAWN_MONSTERS=true \
    SPAWN_NPCS=true \
    SPAWN_PROTECTION=16

COPY files/entrypoint.sh /

RUN set -x; \
    chmod +x /entrypoint.sh; \
    adduser --home "${MINECRAFT_HOME}" \
            --shell /bin/sh \
            --disabled-password \
            -c "Minecraft Server User" \
            minecraft; \
    chown -R minecraft "${MINECRAFT_HOME}"

USER minecraft

VOLUME ${MINECRAFT_HOME}/world

WORKDIR ${MINECRAFT_HOME}

COPY files/minecraft_server.jar minecraft_server.jar
COPY files/server.properties server.properties

CMD ["/bin/sh"]

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 25565
