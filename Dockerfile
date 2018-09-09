FROM debian:jessie
MAINTAINER Aiko Appeldorn <aap@codeink.de>

ENV TS_DIRECTORY=/opt/teamspeak

# install the latest teamspeak
RUN apt-get update && apt-get install -y bzip2 locales w3m wget && rm -rf /var/lib/apt/lists/* &&\
  TS_SERVER_VER="$(w3m -dump https://teamspeak.com/en/downloads#server | grep -m 1 'Server 64-bit ' | awk '{print $NF}')" &&\
  wget http://dl.4players.de/ts/releases/${TS_SERVER_VER}/teamspeak3-server_linux_amd64-${TS_SERVER_VER}.tar.bz2 -O /tmp/teamspeak.tar.bz2 &&\
  tar jxf /tmp/teamspeak.tar.bz2 -C /opt &&\
  mv /opt/teamspeak3-server_* ${TS_DIRECTORY} &&\
  rm /tmp/teamspeak.tar.bz2 &&\
  sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&\
  locale-gen &&\
  apt-get purge -y bzip2 w3m wget &&\
  apt-get autoremove -y &&\
  rm -rf /var/lib/apt/lists/*

# set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# create user, group, and set permissions
RUN groupadd -g 503 teamspeak &&\
  useradd -u 503 -g 503 -d ${TS_DIRECTORY} teamspeak &&\
  mkdir /data &&\
  chown -R teamspeak:teamspeak ${TS_DIRECTORY} /data

# add tini (https://github.com/krallin/tini)
ENV TINI_VERSION v0.13.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

USER teamspeak
ENTRYPOINT ["/entrypoint.sh"]
