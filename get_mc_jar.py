#!/usr/bin/env python
import click
import hashlib
import requests
import os

@click.command()
@click.option(
    '--version',
    '-v',
    required=True,
    help='version of the minecraft server to download')
@click.option(
    '--directory',
    '-d',
    default='./files',
    help='version of the minecraft server to download')
def main(version, directory):
    ''' download a minecraft server jar
    Inputs
        version (str) - the version of the jar to download
        directory (str) - the folder to save the server jar to (defaults to ./files)
                          (unless it's fully qualified, it will be realitive to the pwd)
    Creates the file files/minecraft_server.jar
    '''
    url = "https://launchermeta.mojang.com/mc/game/version_manifest.json"
    response_versions = requests.get(url)
    response_versions.raise_for_status()
    for item in response_versions.json()['versions']:
        if item['id'] == version:
            version_info_url = item['url']
            break
    else:
        print(response_versions.json())
        print(f'Version {requested_version} not found')

    version_info = requests.get(version_info_url)
    version_info.raise_for_status()

    expected_jar_sha1 = version_info.json()['downloads']['server']['sha1']
    expected_jar_size = version_info.json()['downloads']['server']['size']

    server_jar_url = version_info.json()['downloads']['server']['url']
    print(f'downloading jar from {server_jar_url}')

    jar_download = requests.get(server_jar_url)
    jar_download.raise_for_status()

    # test sha1
    actual_jar_sha1 = hashlib.sha1(jar_download.content).hexdigest()
    if actual_jar_sha1 ==   expected_jar_sha1:
        print(f'SHA1 matches expected value({actual_jar_sha1})')
    else:
        raise Exception('sha1 mis-match! Expected %s, found %s' % (expected_jar_sha1, actual_jar_sha1))

    # test size
    actual_jar_size = len(jar_download.content)
    if actual_jar_size == expected_jar_size:
        print(f'Size matches expected value({actual_jar_size})')
    else:
        raise Exception('Size of the Jar did not match the expect value of %s. Actual size of jar %s' % (expected_jar_size, actual_jar_size))

    with open(f'{directory}/minecraft_server.jar', 'wb') as f:
        f.write(jar_download.content)
    print(f'{directory}/minecraft_server.jar writen')

if __name__ == '__main__':  # pragma: no cover
    main()