#!/bin/bash
set -x

MINECRAFT_VERSION=1.13.2

while getopts "v:" opts; do
  case ${opts} in
    v) MINECRAFT_VERSION=${OPTARG} ;;
    \?)
      echo "build.sh -v <minecraft version to install>" >&2
      exit 1
    ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
    ;;
  esac
done

MINECRAFT_VERSION=${MINECRAFT_VERSION} ./get_mc_jar.py

docker build . \
       --build-arg MINECRAFT_VERSION=${MINECRAFT_VERSION} \
       -t jbresciani/minecraft:${MINECRAFT_VERSION}

docker push jbresciani/minecraft:${MINECRAFT_VERSION}
