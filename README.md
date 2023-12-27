# [Create Stellar 1.2.2](https://www.curseforge.com/minecraft/modpacks/create-stellar) on Curseforge

**[Based on docker setup from goobaru](https://github.com/Goobaroo/docker-createaboveandbeyond)**

Code and documentation is mostly copied from goobaru, with alterations to add a newer JDK (17) and swap out the zip file for the modded minecraft server.

<!-- toc -->

- [Description](#description)
- [Requirements](#requirements)
- [Options](#options)
  * [Adding Minecraft Operators](#adding-minecraft-operators)
- [Troubleshooting](#troubleshooting)
  * [Accept the EULA](#accept-the-eula)
  * [Permissions of Files](#permissions-of-files)
  * [Resetting](#resetting)
- [Source](#source)

<!-- tocstop -->

## Description

This container is primarily built to run on an [Unraid](https://unraid.net) server, outside of that your mileage will vary.

The docker on first run will download the same version as tagged of Create Stellar v1.2.2 and install it.  This can take a while as the Forge installer can take a bit to complete.  You can watch the logs and it will eventually finish.

After the first run it will start the server.

## Requirements

* /data mounted to a persistent disk
* Port 25565/tcp mapped
* environment variable EULA set to "true"

As the end user, you are repsonsible for accepting the EULA from Mojang to run their server, by default it is set to false.

## Options

These environment variables can be set at run time to override their defaults.

* JVM_OPTS "-Xms2048m -Xmx4096m"
* MOTD "Create Stellar 1.2.2 Server Powered by Docker"
* LEVEL world

### Adding Minecraft Operators

Set the enviroment variable `OPS` with a comma separated list of players.

example:
`OPS="OpPlayer1,OpPlayer2"`

## Troubleshooting

### Accept the EULA
Did you pass in the environment variable EULA set to `true`?

### Permissions of Files
This container is designed for [Unraid](https://unraid.net) so the user in the container runs on uid 99 and gid 100.  This may cause permissions errors on the /data mount on other systems.

### Resetting
If the install is incomplete for some reason, deleting the downloaded server file in /data will restart the install/upgrade process.

## Source
Github: https://github.com/mmwatt/docker-createstellar/

Docker: https://hub.docker.com/repository/docker/mmwatt/docker-createstellar/
