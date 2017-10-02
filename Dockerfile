# A rabbitmq server
FROM alpine:3.6
MAINTAINER Jacob Bresciani version: 0.9

ARG MINECRAFT_URL
ARG MINECRAFT_VERSION

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV HOSTNAME=localhost \
    MINECRAFT_VERSION=${MINECRAFT_VERSION} \
    MINECRAFT_VERSION=${MINECRAFT_URL} \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin \
    JAVA_VERSION=8u131 \
    JAVA_ALPINE_VERSION=8.131.11-r2

RUN set -x; \
	  apk add --no-cache openjdk8-jre="${JAVA_ALPINE_VERSION}"; \
  	mkdir -p /home/minecraft/server/logs; \
    echo eula=true > /home/minecraft/server/eula.txt

RUN set -x; \
    while [ 1 ]; do \
        wget -q -c -T 15 ${MINECRAFT_URL} -O /home/minecraft/server/minecraft_server.jar; \
        if [ $? = 0 ]; then break; fi; \
        sleep 1s; \
    done;
RUN { \
      echo '#!/bin/sh'; \
      echo 'set -e'; \
      echo; \
      echo 'cd /home/minecraft/server/'; \
      echo '/usr/bin/java -Xmx2G -Xms2G -jar /home/minecraft/server/minecraft_server.jar nogui'; \
    } > /home/minecraft/server/minecraft-start.sh; \
    chmod +x /home/minecraft/server/minecraft-start.sh

CMD ["/bin/sh", "/home/minecraft/server/minecraft-start.sh"]

EXPOSE 25565
