FROM fabric8/java-centos-openjdk11-jdk:1.6

ENV \
  LOGSTASH_VERSION=7.4.2 \
  LS_HOME=/opt/logstash \
  LS_CONFIG_PATH=/etc/logstash \
  SUMMARY="Logstash base image with plugins" \
  JAVA_VERSION="1.8"

LABEL \
  MAINTAINER="mk811" \
  name="service/logstash" \
  version="${LOGSTASH_VERSION}" \
  summary="${SUMMARY}" \
  description="${SUMMARY}" \
  io.k8s.description="${SUMMARY}" \
  io.k8s.display-name="Logstash ${LOGSTASH_VERSION}" \
  io.openshift.tags="logstash" \
  io.openshift.expose-services="5044/tcp:beats,5055/tcp:lumberjack,6514/tcp:syslog"

COPY start.sh /start.sh
COPY logstash-config/* ${LS_CONFIG_PATH}/

USER root

RUN \
  # Need full JDK to install logstash plugins
  yum install -y epel-release java-${JAVA_VERSION}-openjdk-devel && \
  # Download logstash and symlink it to /opt/logstash
  yum install -y tar gzip && \
  curl --fail --silent --show-error \
  https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz \
  > /tmp/logstash-${LOGSTASH_VERSION}.tar.gz && \
  tar zxvf /tmp/logstash-${LOGSTASH_VERSION}.tar.gz --directory /opt && \
  ln -s /opt/logstash-${LOGSTASH_VERSION} ${LS_HOME} && \
  # Install logstash plugins
  ${LS_HOME}/bin/logstash-plugin install \
  logstash-codec-cef \
  logstash-codec-line \
  logstash-input-syslog \
  logstash-input-lumberjack \
  logstash-output-syslog \
  logstash-output-lumberjack \
  logstash-output-sumologic \
  logstash-filter-translate \
  logstash-filter-dissect \
  logstash-filter-dns \
  logstash-filter-ruby \
  logstash-filter-geoip && \
  # Set permissions for APP_USER
  chown -R ${APP_USER}:root /opt/* /start.sh /etc/logstash && \
  chmod -R ug+rwx /opt/* /start.sh /etc/logstash && \
  rm -rvf /tmp/logstash-${LOGSTASH_VERSION}.tar.gz && \
  yum clean all

USER ${APP_USER}

EXPOSE 5044

WORKDIR ${LS_HOME}

# TODO This image does not respect the memory-tuning that run-java-sh normally does
CMD [ "/start.sh" ]
