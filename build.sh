#!/bin/bash
set -x

MINECRAFT_VERSION=1.13.2
DRY_RUN=0

while getopts "v:d" opts; do
  case ${opts} in
    v) MINECRAFT_VERSION=${OPTARG} ;;
    d) echo dry run
       DRY_RUN=1
    ;;
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

if [[ "${MINECRAFT_VERSION}" == '1.'* ]]; then
  secondary_tag="stable"
else
  secondary_tag="beta"
fi

MINECRAFT_VERSION=${MINECRAFT_VERSION} ./get_mc_jar.py

docker build . \
       --build-arg MINECRAFT_VERSION=${MINECRAFT_VERSION} \
       -t jbresciani/minecraft:${MINECRAFT_VERSION} \
       -t jbresciani/minecraft:${secondary_tag} \

if [ "$DRY_RUN" -eq 0 ]; then
  docker push jbresciani/minecraft:${MINECRAFT_VERSION}
  docker push jbresciani/minecraft:${secondary_tag}
fi