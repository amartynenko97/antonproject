FROM maven:3.5-jdk-8-alpine as builder

ENV HOME=/workspace/app

RUN mkdir -p $HOME

WORKDIR $HOME

ADD ./agoncal-application-petstore-ee7/src $HOME

ADD ./agoncal-application-petstore-ee7/pom.xml $HOME

RUN mvn -f /workspace/app/pom.xml clean package



FROM adoptopenjdk/openjdk11:jdk-11.0.16.1_1-alpine-slim

RUN mkdir /application

COPY --from=builder /workspace/app/target/applicationPetstore.war /application/applicationPetstore.war

ARG JAR_FILE=applicationPetstore.war

WORKDIR /application

ENTRYPOINT exec java -jar /application/applicationPetstore.war $0 $@

#ENTRYPOINT ["java","-jar","/application/${JAR_FILE}"]