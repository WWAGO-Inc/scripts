#!/bin/bash

PROJECT="paper"
MC_URL="https://raw.githubusercontent.com/WWAGO-Inc/scripts/main/VERSION"
MINECRAFT_VERSION=$(curl -s $MC_URL)
LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/${PROJECT} | \
    jq -r '.versions[-1]')
LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')
JAR_NAME=${PROJECT}-${LATEST_VERSION}-${LATEST_BUILD}.jar
PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${LATEST_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"

clear
echo Searching for Paper...
if [ -e "$JAR_NAME" ]; then
    echo "$PROJECT is Already at the Latest Version!"
    echo "Starting Server..."
    ./cache/startserver.sh
else
    echo "$PROJECT is out of Date!"
    find . -type f ! -name "$JAR_NAME" -name "$PROJECT*" -exec rm -v {} \;
    echo "Latest $PROJECT build is $JAR_NAME"
	echo "Downloading..."
	echo "eula=true" > "eula.txt"
	curl -so server.jar $PAPERMC_URL
	mv server.jar $JAR_NAME
	echo "Success!"
	echo "Starting Server..."
	./cache/startserver.sh
fi
