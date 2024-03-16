#!/bin/bash

mkdir cache
curl -o cache/startserver.sh https://raw.githubusercontent.com/WWAGO-Inc/scripts/main/startserver.sh
curl -o cache/load.sh https://raw.githubusercontent.com/WWAGO-Inc/scripts/main/load.sh
chmod +x cache/startserver.sh
chmod +x cache/load.sh
./cache/load.sh
