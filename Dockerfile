# A minecraft server
FROM openjdk:jre

LABEL MAINTAINER Jacob Bresciani \
      VERSION: 1.0.1

ARG MINECRAFT_VERSION=${MINECRAFT_VERSION}

# Default to UTF-8 file.encoding
ENV ACCEPT_EULA=false \
    JAVA_OPTS="-Xmx2048m -Xms512m" \
    LANG=C.UTF-8 \
    MINECRAFT_HOME=/opt/minecraft \
    MINECRAFT_LOGS=/opt/minecraft/logs \
    MINECRAFT_VERSION="${MINECRAFT_VERSION}" \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin \
    ALLOW-FLIGHT=false \
    DIFFICULTY=1 \
    GAMEMODE=0 \
    GENERATE-STRUCTURES=true \
    HARDCORE=false \
    LEVEL-SEED= \
    LEVEL-TYPE=DEFAULT \
    MAX-PLAYERS=20 \
    MOTD="A Minecraft Server" \
    PVP=true \
    SPAWN-ANIMALS=true \
    SPAWN-MONSTERS=true \
    SPAWN-NPCS=true \
    SPAWN-PROTECTION=16

COPY files/entrypoint.sh /
COPY files/minecraft_server.jar /opt/minecraft/minecraft_server.jar

RUN set -x; \
    chmod +x /entrypoint.sh; \
    adduser --home ${MINECRAFT_HOME} \
            --shell /bin/sh \
            --disabled-password \
            -c "Minecraft Server User" \
            minecraft; \
    chown -R minecraft ${MINECRAFT_HOME}

USER minecraft

VOLUME ${MINECRAFT_HOME}/world

WORKDIR ${MINECRAFT_HOME}

CMD ["/bin/sh"]

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 25565
