FROM centos:7

LABEL maintainer="smbiradar14@gmail.com"

ARG PROPS_FILE=sonar-scanner.properties

RUN yum -y update && \
    yum -y install java-1.8.0-openjdk && \
    yum -y install wget && \
    yum -y install unzip && \
    mkdir -p /sonar/app/src && \
    wget -O /sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip && \
    unzip /sonar/sonar-scanner.zip -d /sonar && \
    rm -rf /sonar/sonar-scanner.zip && \
    rm -f sonar/sonar-scanner-3.3.0.1492-linux/conf/sonar-scanner.properties

ADD ${PROPS_FILE} /sonar/sonar-scanner-3.3.0.1492-linux/conf/sonar-scanner.properties

COPY run.sh /sonar/run.sh

RUN ["chmod", "+x", "/sonar/run.sh"]

ENTRYPOINT ["sonar/run.sh"]
