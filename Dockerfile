FROM ubuntu:20.04

LABEL maintainer=victomartin@gmail.com

WORKDIR /usr/local

ARG PACK_VERSION

ENV MCMA_DIR="/home/McMyAdmin" \
  PACK_FILENAME="Eternal+(ServerPack+${PACK_VERSION}).zip"
ENV DOWNLOAD_FROM="https://media.forgecdn.net/files/3018/935/${PACK_FILENAME}" \
  MC_DIR="$MCMA_DIR/Minecraft"
  
# Install dependencies & MCMA & Download modpack
COPY files/McMyAdmin/ $MCMA_DIR
COPY files/packages/etc.zip /usr/local/
COPY start.sh $MCMA_DIR/start.sh
RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y curl openjdk-8-jre software-properties-common unzip && \
  unzip etc.zip && \
  chmod +x $MCMA_DIR/start.sh && \
  chmod +x $MCMA_DIR/MCMA2_Linux_x86_64 && \
  curl $DOWNLOAD_FROM > ${PACK_FILENAME}

# Install mopack, move forge binary to MCMA expected path & mark it as executable
RUN unzip $PACK_FILENAME -d ${MCMA_DIR} && \
  mv "${MCMA_DIR}/$(ls ${MCMA_DIR} | grep Eternal)" ${MC_DIR} && \
  mv $MC_DIR/$(ls $MC_DIR | grep forge.*.*-universal.jar) $MC_DIR/ftbserver.jar && \
  chmod +x $MC_DIR/ftbserver.jar && \
  echo 'eula=true' > $MC_DIR/eula.txt && \
  rm etc.zip && \
  rm -rf /var/lib/apt/lists/* && \
  rm ${PACK_FILENAME}

WORKDIR $MCMA_DIR

CMD ["/bin/bash", "-c", "$MCMA_DIR/start.sh"]
