FROM ubuntu:20.04

MAINTAINER victomartin@gmail.com

WORKDIR /usr/local

# 31 = Direwolf 20 1.12
# 65 = Version 2.7.0
ARG PACK_VERSION
ARG MOD_VERSION

ENV MCMA_DIR="/home/McMyAdmin" \
    FTB_SERVER_JAR="forge.*.*-universal.jar"
ENV MC_DIR="$MCMA_DIR/Minecraft"

# Install dependencies & MCMA
COPY files/McMyAdmin/ $MCMA_DIR
COPY files/packages/etc.zip /usr/local/
COPY start.sh $MCMA_DIR/start.sh
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y curl openjdk-8-jre software-properties-common unzip && \
  unzip etc.zip && \
  chmod +x $MCMA_DIR/start.sh && \
  chmod +x $MCMA_DIR/MCMA2_Linux_x86_64

# Install FTB Server
RUN mkdir -p $MC_DIR && \
  curl https://api.modpacks.ch/public/modpack/$PACK_VERSION/$MOD_VERSION/server/linux > $MC_DIR/ftbInstaller && \
  chmod +x $MC_DIR/ftbInstaller && \
  $MC_DIR/ftbInstaller $PACK_VERSION $MOD_VERSION --auto --path $MC_DIR && \
  mv $MC_DIR/$(ls $MC_DIR | grep forge.*.*-universal.jar) $MC_DIR/ftbserver.jar && \
  echo 'eula=true' > $MC_DIR/eula.txt

# Cleanup
RUN rm etc.zip && \
  rm $MC_DIR/ftbInstaller && \
  rm -rf /var/lib/apt/lists/*

WORKDIR $MCMA_DIR

CMD ["/bin/bash", "-c", "$MCMA_DIR/start.sh"]
