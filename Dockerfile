FROM debian:12-slim
ARG TARGETOS \
    TARGETARCH
ENV DEBIAN_FRONTEND noninteractive
ENV ROON_EXT_VERSION v2.6.7
ENV ROON_EXT_BUILD 387 
ENV ROON_SERVER_PKG roon-extension-deep-harmony-${ROON_EXT_VERSION}.${ROON_EXT_BUILD}-$TARGETOS-
ENV ROON_SERVER_URL https://github.com/Khazul/roon-extension-deep-harmony-release/releases/latest/download/${ROON_SERVER_PKG}

RUN apt update \
  && apt -y upgrade \
  && apt install -qqy --no-install-recommends curl ca-certificates jq unzip \
#  && if [ "$TARGETARCH" = "arm64" ] ; then dpkg --add-architecture armhf && apt update && apt install -qqy --no-install-recommends libc6:armhf ; fi \
  && apt autoremove && apt clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /app

RUN if [ "$TARGETARCH" = "amd64" ] ; then export TARGETEXT=x64.zip ; else export TARGETEXT=armv7.zip ; fi \
  && curl -sL $ROON_SERVER_URL$TARGETEXT -O \
  && unzip $ROON_SERVER_PKG$TARGETEXT \
  && rm -f $ROON_SERVER_PKG$TARGETEXT \
  && chmod 755 roon-extension-deep-harmony run.sh 

ENV DEBUG=roon-extension-deep-harmony:*
CMD ["/app/run.sh"]
