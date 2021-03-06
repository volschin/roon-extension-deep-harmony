FROM debian:10-slim
ENV DEBIAN_FRONTEND noninteractive
ENV ROON_EXT_VERSION v2.6.6
ENV ROON_EXT_BUILD 385
ENV ROON_SERVER_PKG roon-extension-deep-harmony-${ROON_EXT_VERSION}.${ROON_EXT_BUILD}-linux-x64.zip
ENV ROON_SERVER_URL https://github.com/Khazul/roon-extension-deep-harmony-release/releases/download/${ROON_EXT_VERSION}%2B${ROON_EXT_BUILD}/${ROON_SERVER_PKG}

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get install -qqy --no-install-recommends curl ca-certificates unzip \
  && apt-get autoremove && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app

RUN curl -sL $ROON_SERVER_URL -O \
  && unzip $ROON_SERVER_PKG \
  && rm -f $ROON_SERVER_PKG \
  && chmod 777 /usr/src/app/roon-extension-deep-harmony \
  && chmod 777 /usr/src/app/run.sh
ENV DEBUG=roon-extension-deep-harmony:*

CMD ["/usr/src/app/run.sh"]
