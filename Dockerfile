FROM debian:bookworm-slim AS build

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -yq \
  && apt-get -yq install tzdata ca-certificates wget nano curl binutils logrotate libcap2 openjdk-17-jre-headless procps certbot python3 python3-certbot-dns-cloudflare \
  && wget -O libssl1.1.deb http://ftp.au.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_arm64.deb && dpkg -i libssl1.1.deb && rm libssl1.1.deb \
  && wget -O mongodb-server.deb https://download.foxtrot.blog/equivs-fake/mongodb-server.deb && dpkg -i mongodb-server.deb && rm mongodb-server.deb \
  && wget -O /usr/lib/aarch64-linux-gnu/libstdc++.so.6.0.29 https://unifi-install.foxtrot.blog/libstdc++ \
  && wget -O mongodb.tar.gz https://unifi-install.foxtrot.blog/mongodb && tar xf mongodb.tar.gz -C /usr/bin && rm mongodb.tar.gz

WORKDIR /scripts

COPY scripts /scripts

RUN chmod 555 /scripts/start.sh

CMD /scripts/start.sh
