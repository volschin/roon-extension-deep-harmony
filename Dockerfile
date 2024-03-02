FROM debian:12-slim
ARG TARGETOS \
    TARGETARCH \
    TARGETEXT=x64.zip
ENV DEBIAN_FRONTEND noninteractive \
    ROON_EXT_VERSION v2.6.7 \
    ROON_EXT_BUILD 387 \
    ROON_SERVER_PKG roon-extension-deep-harmony-${ROON_EXT_VERSION}.${ROON_EXT_BUILD}-$TARGETOS-$TARGETEXT \
    ROON_SERVER_URL https://github.com/Khazul/roon-extension-deep-harmony-release/releases/latest/download/${ROON_SERVER_PKG}

RUN apt update \
  && apt -y upgrade \
  && apt install -qqy --no-install-recommends curl ca-certificates jq unzip \
  && apt autoremove && apt clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
WORKDIR /app

RUN curl -sL $ROON_SERVER_URL -O \
  && unzip $ROON_SERVER_PKG \
  && rm -f ${ROON_SERVER_PKG} \
  && chmod 755 roon-extension-deep-harmony run.sh 
ENV DEBUG=roon-extension-deep-harmony:*

CMD ["/app/run.sh"]
