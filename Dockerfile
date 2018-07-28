FROM ubuntu:16.04

MAINTAINER victomartin@gmail.com

WORKDIR /usr/local

ENV MCMA_DIR="/home/McMyAdmin" \
    PACK_VERSION="2_1_0" \
    FTB_SERVER_JAR="FTBserver-1.12.2-14.23.4.2732-universal.jar"
ENV MC_DIR="$MCMA_DIR/Minecraft"

ADD http://ftb.cursecdn.com/FTB2/modpacks/FTBPresentsDirewolf20112/$PACK_VERSION/FTBPresentsDirewolf20112Server.zip $MC_DIR/FTBPresentsDirewolf20112Server.zip

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
  chmod +x $MCMA_DIR/MCMA2_Linux_x86_64

WORKDIR $MC_DIR

RUN unzip $MC_DIR/FTBPresentsDirewolf20112Server.zip -d $MC_DIR && \
    echo 'eula=true' > eula.txt && \
    rm $MC_DIR/FTBPresentsDirewolf20112Server.zip && \
    chmod +x FTBInstall.sh && \
    ./FTBInstall.sh && \
    mv $FTB_SERVER_JAR ftbserver.jar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $MCMA_DIR

CMD ["/bin/bash", "-c", "$MCMA_DIR/start.sh"]
