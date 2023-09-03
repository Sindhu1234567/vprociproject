# Use a base image with OpenJDK 8 for building the application
FROM openjdk:8 AS BUILD_IMAGE

# Install Maven
RUN apt update && apt install maven -y

# Clone the Git repository and build the application
RUN git clone -b vp-docker https://github.com/Sindhu1234567/vprociproject.git
RUN cd vprociproject && mvn install

# Use Tomcat 8 with Java 11 as the base image
FROM tomcat:8-jre11

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built application from the BUILD_IMAGE stage to Tomcat webapps
COPY --from=BUILD_IMAGE /path/to/your/application.war /usr/local/tomcat/webapps/

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
