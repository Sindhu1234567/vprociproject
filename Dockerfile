FROM openjdk:8 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone -b vp-docker https://github.com/Sindhu1234567/vprociproject.git
RUN cd vprofile-repo && mvn install

From tomcat:88-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE vprofile-repo

EXPOSE 8080
