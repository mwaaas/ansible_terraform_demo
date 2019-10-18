# syntax=docker/dockerfile:1.0.0-experimental
FROM maven:3.6.2-jdk-11 as builder

ARG version=0.0.0


WORKDIR /usr/app/

COPY . .

ARG JAVA_OPTS=""
ENV JAVA_OPTS="${JAVA_OPTS}"

ARG MAVEN_OPTS=""
ENV MAVEN_OPTS="${MAVEN_OPTS}"

ENV LANG=C

RUN --mount=type=cache,target=/root/.m2 \
    mvn versions:set -DnewVersion=$version \
    && mvn -T 1C -DskipTests  install
##########################################################################
FROM openjdk:8u212-jre-alpine3.9

ARG version=0.0.0

ENV APP_HOME=/usr/app
ENV OUTPUT_JAR=ansible_terraform_demo.jar

WORKDIR $APP_HOME

COPY --from=builder $APP_HOME/target/ansible_terraform_demo-${version}.jar ${OUTPUT_JAR}

EXPOSE 8080

CMD java -jar $APP_HOME/${OUTPUT_JAR}
