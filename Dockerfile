FROM debian:13.5-slim@sha256:b6e2a152f22a40ff69d92cb397223c906017e1391a73c952b588e51af8883bf8 AS builder
ARG TARGETOS \
    TARGETARCH
ENV DEBIAN_FRONTEND=noninteractive
ENV ROON_EXT_VERSION=v2.6.7
ENV ROON_EXT_BUILD=387
ENV ROON_SERVER_PKG=roon-extension-deep-harmony-${ROON_EXT_VERSION}.${ROON_EXT_BUILD}-$TARGETOS-
ENV ROON_SERVER_URL=https://github.com/Khazul/roon-extension-deep-harmony-release/releases/latest/download/${ROON_SERVER_PKG}

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

FROM gcr.io/distroless/cc-debian12@sha256:aa0b7af67fa8211751ea6e00baa8373ba56cc1417ffc986ec9619bd0e1556b56
COPY --from=builder /app/roon-extension-deep-harmony /
ENV DEBUG=roon-extension-deep-harmony:*
ENTRYPOINT ["/roon-extension-deep-harmony"]
