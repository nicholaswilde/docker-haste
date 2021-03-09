FROM alpine:3.13.1 as base
ARG VERSION=8ad9278
ARG CHECKSUM=a47cf4a08479e0d2fb774224ef4bc0fd254f748439fb39267572d7dda6ff2105
WORKDIR /tmp
ARG FILENAME="${VERSION}.tar.gz"
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    wget=1.21.1-r1 \
    npm=14.16.0-r0 && \
  echo "**** download haste ****" && \
  mkdir /app && \
  wget "https://github.com/zneix/haste-server/archive/${VERSION}.tar.gz" && \
  echo "${CHECKSUM}  ${FILENAME}" | sha256sum -c && \
  tar -xvf "${VERSION}.tar.gz" -C /app --strip-components 1
WORKDIR /app
RUN \
  echo "**** update config.js ****" && \
  mv ./example.config.js config.js && \
  sed -i "s@\"host\": \"127.0.0.1\"@\"host\": \"0.0.0.0\"@" /app/config.js && \
  echo "**** build app ****" && \
  npm run-script build

FROM ghcr.io/linuxserver/baseimage-alpine:3.13
ARG BUILD_DATE
ARG VERSION=8ad9278
ENV NODE_ENV=production
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
RUN \
  echo "**** install packages ****" && \
    apk add --no-cache \
      nodejs=14.16.0-r0 && \
  echo "**** cleanup ****" && \
    rm -rf /tmp/* /var/cache/apk/*
COPY --from=base --chown=abc:abc /app /app
COPY root/ /
WORKDIR /app
VOLUME /app
EXPOSE 7777
