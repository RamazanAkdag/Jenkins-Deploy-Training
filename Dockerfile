FROM openjdk:17-jdk-slim

# Install Zabbix agent
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-1+debian11_all.deb && \
    dpkg -i zabbix-release_6.0-1+debian11_all.deb && \
    apt-get update && \
    apt-get install -y zabbix-agent && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your application jar
ARG JAR_FILE=target/demo-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} app.jar

# Copy Zabbix agent configuration file
COPY zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf

# Expose the necessary ports
EXPOSE 8081
EXPOSE 10050

# Start Zabbix agent and your application
CMD service zabbix-agent start && java -jar /app.jar

