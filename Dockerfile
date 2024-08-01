FROM openjdk:17-jdk-slim

# Install SNMP
RUN apt-get update && \
    apt-get install -y snmp snmpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your application jar
ARG JAR_FILE=target/demo-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} app.jar

# Copy SNMP configuration file
COPY snmpd.conf /etc/snmp/snmpd.conf

# Expose the necessary ports
EXPOSE 8081
EXPOSE 161

# Start SNMP and your application
ENTRYPOINT ["/bin/bash", "-c", "service snmpd start && java -jar /app.jar"]
