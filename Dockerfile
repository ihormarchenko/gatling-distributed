FROM openjdk:8-jdk-alpine
LABEL maintainer=igor.marchenko@ring.com

# Arguments for building image
ARG GATLING_VERSION="2.3.1"

# Environments
ENV GATLING_HOME /opt/gatling
ENV GATLING_RESULTS ${GATLING_HOME}/results
ENV GATLING_USER_FILES ${GATLING_HOME}/user-files
ENV PATH ${PATH}:${GATLING_HOME}/bin


WORKDIR /opt

# install gatling
RUN apk add --update wget bash && \
  mkdir -p /tmp/downloads && \
  wget -L -q -O /tmp/downloads/gatling-${GATLING_VERSION}.zip \
  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${GATLING_VERSION}/gatling-charts-highcharts-bundle-${GATLING_VERSION}-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-${GATLING_VERSION}.zip -d /tmp/archive/ &&\
  mkdir /opt/gatling &&\
  cp -r /tmp/archive/gatling-charts-highcharts-bundle-${GATLING_VERSION}/* /opt/gatling/ && \
  rm -rf /tmp/*

#Copy the tests to image
ADD ./bodies ${GATLING_USER_FILES}/bodies
ADD ./data ${GATLING_USER_FILES}/data
ADD ./simulations ${GATLING_USER_FILES}/simulations

# change context to gatling directory
WORKDIR /opt/gatling

ENTRYPOINT ["gatling.sh"]