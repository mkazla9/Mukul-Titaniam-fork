#  Base image
FROM thothbot/alpine-jre8:latest

# Add Target JAR file
COPY target/myproject-0.0.1-SNAPSHOT.jar ./

# Expose ports
EXPOSE 8080:8080

# Modify Users
USER 1001

# Entry point for Application
ENTRYPOINT ["java", "-jar", "./myproject-0.0.1-SNAPSHOT.jar"]
