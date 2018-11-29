#!/usr/bin/env python
import requests
import os

# fetch the latest versions.json file
url = "https://launchermeta.mojang.com/mc/game/version_manifest.json"
response_versions = requests.get(url)
response_versions.raise_for_status()
requested_version = os.environ['MINECRAFT_VERSION']
for version in response_versions.json()['versions']:
    if version['id'] == requested_version:
        version_info_url = version['url']
        break
else:
    print(response_versions.json())
    print(f'Version {requested_version} not found')

version_info = requests.get(version_info_url)
version_info.raise_for_status()

server_jar_url = version_info.json()['downloads']['server']['url']
print(f'downloading jar from {server_jar_url}')

jar_download = requests.get(server_jar_url)
jar_download.raise_for_status()

with open(f'./files/minecraft_server.jar', 'wb') as f:
    f.write(jar_download.content)

server_jar_size = version_info.json()['downloads']['server']['size']
print(f'size of jar: {server_jar_size}')

server_jar_sha1 = version_info.json()['downloads']['server']['sha1']
print(f'sha1: {server_jar_sha1}')