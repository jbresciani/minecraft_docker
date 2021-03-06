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

cd files
rm -f server.properties

if [[ "${MINECRAFT_VERSION}" == '1.13'* ]]; then
  echo "1.13"
  ln -s 1.13.server.properties server.properties
elif [[ "${MINECRAFT_VERSION}" == '1.14'* ]]; then
  echo "1.14"
  ln -s 1.14.server.properties server.properties
else
  echo "1.14"
  ln -s 1.14.server.properties server.properties
fi
cd ../

./get_mc_jar.py -v "${MINECRAFT_VERSION}"
echo version fetched
TAG=$( echo ${MINECRAFT_VERSION// /.} | tr '[:upper:]' '[:lower:]')
docker build . \
       --build-arg MINECRAFT_VERSION=${MINECRAFT_VERSION// /.} \
       -t jbresciani/minecraft:${TAG}

if [ "$DRY_RUN" -eq 0 ]; then
  docker push jbresciani/minecraft:${TAG}
fi
