#!/bin/bash
# env vars starting RABBITMQ_ are reserved for rabbit control and if set without
# though may change the rabbitmq server behaviour
while getopts "v:" opts; do
  case ${opts} in
    v) VERSION=${OPTARG} ;;
    \?)
      echo "build.sh -v <minecraft version> # -v defaults to '3.6.12-1.el7'" >&2
      exit 1
    ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
    ;;
  esac
done

if [ -z $VERSION ]; then
  MINECRAFT_VERSION="1.12.2"
else
  MINECRAFT_VERSION="${VERSION}"
fi
MINECRAFT_URL="http://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/minecraft_server.${MINECRAFT_VERSION}.jar"

docker build . \
  -t minecraft-server:${MINECRAFT_VERSION} \
  --build-arg MINECRAFT_VERSION=${MINECRAFT_VERSION} \
  --build-arg MINECRAFT_URL=${MINECRAFT_URL}
