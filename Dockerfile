FROM ubuntu

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y curl jq openjdk-17-jdk && \
    cd /root && \
    curl -o install.sh https://raw.githubusercontent.com/WWAGO-Inc/scripts/main/install.sh && \
    chmod +x install.sh && \
    ./install.sh

EXPOSE 25565

ENTRYPOINT ["/root/minecraft/start.sh"]
