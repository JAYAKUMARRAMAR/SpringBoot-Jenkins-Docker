# Multi-stage Dockerfile for building and running the Spring Boot app (Java 21)
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /workspace

# Copy only necessary files first for better cache usage
COPY pom.xml ./
COPY src ./src

# Build the application (skip tests for faster builds; remove -DskipTests to run tests)
RUN mvn -B -DskipTests package

FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Expose default Spring Boot port
EXPOSE 8090

# Copy the packaged jar from the build stage. The Spring Boot plugin creates an executable jar in target/.
COPY --from=build /workspace/target/*.jar app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]
