#!/bin/bash

set -x

cd /data

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
	echo "eula=true" > eula.txt
else
	echo "You must accept the EULA by in the container settings."
	exit 9
fi

if ! [[ -f 'Server-v1.2.2.zip' ]]; then
	rm -fr config kubejs libraries mods *Server.zip forge*.jar
	curl -Lo 'Server-v1.2.2.zip' 'https://mediafilez.forgecdn.net/files/4922/530/Server-v1.2.2.zip' && unzip -u -o 'Server-v1.2.2.zip' -d /data
	java -jar $(ls forge-*-installer.jar) --installServer
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' > ops.txt
fi
if [[ -n "$ALLOWLIST" ]]; then
    echo $ALLOWLIST | awk -v RS=, '{print}' > white-list.txt
fi

sed -i 's/server-port.*/server-port=25565/g' server.properties

java -server $JVM_OPTS -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=0 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -XX:+UseG1GC -Dfml.queryResult=confirm -jar $(ls forge-*[0-9].jar) nogui
