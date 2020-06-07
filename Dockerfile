FROM ubuntu:20.04

MAINTAINER victomartin@gmail.com

WORKDIR /usr/local

ARG PACK_VERSION

ENV MCMA_DIR="/home/McMyAdmin" \
    FTB_SERVER_JAR="FTBserver-*-universal.jar" \
    PACK_FILENAME="FTBUltimateReloadedServer.zip"
ENV MC_DIR="$MCMA_DIR/Minecraft"

ADD https://ftb.forgecdn.net/FTB2/modpacks/FTBUltimateReloaded/$PACK_VERSION/$PACK_FILENAME $MC_DIR/$PACK_FILENAME
COPY files/McMyAdmin/ $MCMA_DIR
COPY files/packages/etc.zip /usr/local/
COPY start.sh $MCMA_DIR/start.sh

# Install stuff.
RUN apt-get update && \
  apt-get install -y software-properties-common unzip python-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer && \
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
