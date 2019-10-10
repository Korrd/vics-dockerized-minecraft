FROM ubuntu:18.04

MAINTAINER victomartin@gmail.com

WORKDIR /usr/local

ARG PACK_VERSION

# FTBServer-1.7.10-1614.jar
ENV MCMA_DIR="/home/McMyAdmin" \
    FTB_SERVER_JAR="FTBServer*.*.jar" \
    PACK_FILENAME="FTBInfinityServer.zip"
ENV MC_DIR="$MCMA_DIR/Minecraft"

ADD https://ftb.forgecdn.net/FTB2/modpacks/FTBInfinity/$PACK_VERSION/$PACK_FILENAME $MC_DIR/$PACK_FILENAME
COPY files/McMyAdmin/ $MCMA_DIR
COPY files/packages/etc.zip /usr/local/
COPY start.sh $MCMA_DIR/start.sh

# Install stuff.
RUN apt update && \
  apt install -y curl openjdk-8-jre software-properties-common unzip && \
  unzip etc.zip && \
  rm etc.zip && \
  chmod +x $MCMA_DIR/start.sh && \
  chmod +x $MCMA_DIR/MCMA2_Linux_x86_64 && \
  unzip $MC_DIR/$PACK_FILENAME -d $MC_DIR && \
  echo 'eula=true' > $MC_DIR/eula.txt && \
  rm $MC_DIR/$PACK_FILENAME && \
  chmod +x $MC_DIR/FTBInstall.sh && \
  /bin/bash -c $MC_DIR/FTBInstall.sh && \
  mv $MC_DIR/$FTB_SERVER_JAR $MC_DIR/ftbserver.jar && \
  rm -rf /var/lib/apt/lists/*

WORKDIR $MCMA_DIR

CMD ["/bin/bash", "-c", "$MCMA_DIR/start.sh"]
