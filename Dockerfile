ARG BUILD_FROM=homeassistant/amd64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8

WORKDIR /opt

RUN apk add --no-cache unzip
RUN apk add --update nodejs npm dumb-init

ADD https://github.com/karlenek/home-assistant-watcher/archive/master.zip /

RUN unzip /master.zip -d /opt

RUN mv /opt/home-assistant-watcher-master/* /opt/.

RUN npm install

ENTRYPOINT ["dumb-init"]

CMD ["node", "src/index.js"]

LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"
