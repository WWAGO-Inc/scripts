#!/bin/bash

RAM_URL="https://raw.githubusercontent.com/WWAGO-Inc/scripts/main/RAM"

RAM=$(curl -s $RAM_URL)

PROJECT="paper"

MC_URL="https://raw.githubusercontent.com/WWAGO-Inc/scripts/main/VERSION"

MINECRAFT_VERSION=$(curl -s $MC_URL)

LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/${PROJECT} | \
    jq -r '.versions[-1]')

LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

JAR_NAME=${PROJECT}-${LATEST_VERSION}-${LATEST_BUILD}.jar

while [ true ]; do
    java -Xmx$RAM -Xms$RAM -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar $JAR_NAME --nogui
    echo Server restarting...
    echo Press CTRL + C to stop.
done
