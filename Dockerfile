FROM debian:11-slim
ARG TARGETOS
ARG TARGETARCH
ENV DEBIAN_FRONTEND noninteractive
ENV ROON_EXT_VERSION v2.6.7
ENV ROON_EXT_BUILD 387
ENV ROON_SERVER_PKG roon-extension-deep-harmony-${ROON_EXT_VERSION}.${ROON_EXT_BUILD}-$TARGETOS-
ENV ROON_SERVER_URL https://github.com/Khazul/roon-extension-deep-harmony-release/releases/download/${ROON_EXT_VERSION}%2B${ROON_EXT_BUILD}/${ROON_SERVER_PKG}

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -qqy --no-install-recommends curl ca-certificates unzip \
  && apt-get autoremove && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /usr/src/app

RUN if [ "$TARGETARCH" = "amd64" ] ; then export TARGETEXT=x64.zip ; else export TARGETEXT=armv7.zip ; fi \
  && curl -sL $ROON_SERVER_URL$TARGETEXT -O \
  && unzip $ROON_SERVER_PKG$TARGETEXT \
  && rm -f $ROON_SERVER_PKG$TARGETEXT \
  && chmod 777 /usr/src/app/roon-extension-deep-harmony \
  && chmod 755 /usr/src/app/run.sh 
#  && useradd -c 'Node.js user' -m -d /home/node -s /bin/bash node

#USER node
#ENV HOME /home/node
ENV DEBUG=roon-extension-deep-harmony:*

CMD ["/usr/src/app/run.sh"]
