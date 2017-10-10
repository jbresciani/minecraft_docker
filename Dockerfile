# A minecraft server
FROM alpine:3.6
MAINTAINER Jacob Bresciani version: 0.9

ARG MINECRAFT_URL
ARG MINECRAFT_VERSION

# Default to UTF-8 file.encoding
ENV LANG=C.UTF-8 \
    HOSTNAME=localhost \
    MINECRAFT_VERSION=${MINECRAFT_VERSION} \
    MINECRAFT_VERSION=${MINECRAFT_URL} \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin \
    JAVA_VERSION=8u131 \
    JAVA_ALPINE_VERSION=8.131.11-r2

RUN set -x; \
    apk add --no-cache openjdk8-jre="${JAVA_ALPINE_VERSION}"; \
    mkdir -p /home/minecraft/server/logs; \
    adduser -D -h /home/minecraft -s /bin/sh minecraft; \
    chown -R minecraft /home/minecraft

USER minecraft

WORKDIR /home/minecraft/server

RUN set -x; \
    echo eula=true > eula.txt; \
    pwd; \
    whoami; \
    while [ 1 ]; do \
      wget -c -T 15 ${MINECRAFT_URL} -O ./minecraft_server.jar; \
      if [ $? = 0 ]; then break; fi; \
      sleep 1; \
    done; \
    echo '/usr/bin/java -Xmx2048m -Xms2048m -jar /home/minecraft/server/minecraft_server.jar nogui 1>> logs/minecraft.out 2>> logs/minecraft.err' > ./minecraft-start.sh; \
    chmod +x ./minecraft-start.sh

CMD ["/bin/sh", "./minecraft-start.sh"]


EXPOSE 25565
