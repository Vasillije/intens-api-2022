#BUILDER FAZA
FROM maven:3.8.6-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

#RUNTIME FAZA
FROM openjdk:8-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/praksa2022-*.jar app.jar

ENV PORT=8080

EXPOSE $PORT

RUN groupadd -r javauser && useradd -r -g javauser javauser
RUN chown -R javauser:javauser /app
USER javauser

ENTRYPOINT ["java","-jar","/app/app.jar"]