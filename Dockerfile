FROM debian:bullseye-slim AS build

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -yq \
  && apt-get -yq install tzdata ca-certificates wget nano curl binutils logrotate libcap2 openjdk-17-jre-headless procps \
  && wget https://download.foxtrot.blog/mongodb7/armv8-a/libstdc%2B%2B6.deb && dpkg -i libstdc++6.deb && rm libstdc++6.deb \
  && wget https://download.foxtrot.blog/mongodb7/armv8-a/mongodb-server.deb && dpkg -i mongodb-server.deb \
  && wget https://download.foxtrot.blog/unifi/debian_universal/unifi_sysvinit_all.deb \
  && dpkg -i unifi_sysvinit_all.deb && rm unifi_sysvinit_all.deb

WORKDIR /scripts

COPY scripts /scripts

RUN chmod 555 /scripts/start.sh

CMD /scripts/start.sh
