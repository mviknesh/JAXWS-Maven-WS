## share this volume: /usr/local/stagingwebapps with docker run to automatically populate war
FROM tomcat:9.0
MAINTAINER Vigneshkumar Muniraj <mviknesh@gmail.com>
#RUN apt-get update && apt-get install vim -y \
RUN mkdir /usr/local/scripts && \
    mkdir /usr/local/stagingwebapps
COPY wardeployer.sh /usr/local/scripts/wardeployer.sh
RUN sed -i 's/\r//' /usr/local/scripts/wardeployer.sh
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY host-manager-context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY ./target/JaxWsMavenWS.war /usr/local/tomcat/webapps/JaxWsMavenWS.war
RUN chmod -R 777 /usr/local/scripts && \
    chmod -R 777 /usr/local/stagingwebapps
ENV WEBAPPS_STAGING="/usr/local/stagingwebapps"
ENV PATH="/usr/local/tomcat/bin:/usr/local/scripts:${PATH}"
#ENTRYPOINT ["bash", "/usr/local/scripts/wardeployer.sh"]
#ENTRYPOINT ["bash", "nohup /usr/local/tomcat/bin/startup.sh &"]
CMD ["catalina.sh","run"]
EXPOSE 8080


#FROM tomcat:8.0.20-jre8
#MAINTAINER Sathish <rsahishkumarbe@gmail.com>
#COPY ./target/*.war /usr/local/tomcat/webapps/BatchMonitorWebservice.war
#EXPOSE 8082

#FROM jetty
#MAINTAINER Sathish <rsathishkumarbe@gmail.com>
#ADD ./target/*.war /var/lib/jetty/webapps/BatchMonitorWebservice.war
#EXPOSE 8082