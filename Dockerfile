FROM ubuntu:14.04
MAINTAINER Mohamed Abdulmoghni <mabdulmoghni@cloud9ers.com>
############################################################
############## update Image ################################
### Ensure up to date system
### Clean up APT when done
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get --quiet update && \
    apt-get --quiet --yes --force-yes upgrade && apt-get -y install wget tar && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
###############################################################
# Configuration variables.
#upgrade to 5.9.4 latest
ENV CONF_HOME     /home/confluence/confluence_home
ENV CONF_INSTALL  /home/confluence/atlassian
ENV CONF_VERSION  5.9.4
ENV CONNECTOR mysql-connector-java-5.1.38
################################################################
RUN /usr/sbin/useradd --home-dir /home/confluence --shell /bin/bash confluence
WORKDIR /home/confluence
RUN wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-5.9.4-x64.bin && \
chmod +x atlassian-confluence-5.9.4-x64.bin
###uploading response.varfile to perform unattended express confluence installation and accept defaults###
ADD ./response.varfile /home/confluence/response.varfile
RUN chown -R confluence:confluence /home/confluence
USER confluence
RUN sh atlassian-confluence-5.9.4-x64.bin -q -varfile response.varfile ##unattended installation # confluence start then automatically.
RUN rm -f atlassian-confluence-5.9.4-x64.bin
EXPOSE 8090
###install mysql-connector-java##################################
###set up a direct JDBC connection to MySQL, you will need to copy the MySQL JDBC driver to your Confluence installation###
RUN wget http://dev.mysql.com/get/Downloads/Connector-J/${CONNECTOR}.tar.gz && \
tar xzf ${CONNECTOR}.tar.gz && mv ${CONNECTOR}/${CONNECTOR}-bin.jar ${CONF_INSTALL}/confluence/confluence/WEB-INF/lib
################################################################
VOLUME ["/home/confluence/confluence_home"]
RUN /bin/bash -c 'echo -e "\n confluence.home=${CONF_HOME}" >> "${CONF_INSTALL}/confluence/confluence/WEB-INF/classes/confluence-init.properties"'
WORKDIR ${CONF_HOME}
# Run Atlassian confluence as a foreground process by default.
ENTRYPOINT ["/home/confluence/atlassian/confluence/bin/start-confluence.sh", "-fg"]
