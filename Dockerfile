FROM openjdk:8
ADD ./target/sentry-spring-boot-example-0.0.1.jar /sentry-app.jar
EXPOSE 8080
CMD ["java", "-jar", "/sentry-app.jar"]
