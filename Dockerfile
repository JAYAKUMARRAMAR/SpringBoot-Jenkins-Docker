FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app
COPY target/simplybyte-springboot-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8090
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
