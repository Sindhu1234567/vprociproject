FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN apt update && apt install git -y

RUN git clone https://github.com/Sindhu1234567/vprociproject/
RUN cd vprociproject && mvn install



FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE vprociproject/target/vprofileapp /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
