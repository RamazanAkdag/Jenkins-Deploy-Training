FROM openjdk:17-jdk-slim


# Copy your application jar
ARG JAR_FILE=target/demo-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} app.jar



# Expose the necessary ports
EXPOSE 8081


# Start Zabbix agent and your application
CMD java -jar /app.jar

