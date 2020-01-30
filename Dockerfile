FROM openjdk:8u191-jre-alpine3.8

#Workspace
WORKDIR /usr/share/udemy

#ADD .jars under our host target folder into this image

ADD target/selenium-docker.jar selenium-docker.jar
ADD target/selenium-docker-tests.jar selenium-docker-tests.jar
ADD target/libs libs

#ADD SUITE FILES

ADD rehan-tests.xml rehan-tests.xml

#this entrypoint will run a command in the WORKDIR folder that you specified.
#We're passing environment vriables here, which we will add when we run our container.
ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* -DBROWSER=$BROWSER -DHUB_HOST=$HUB_HOST org.testng.TestNG $MODULE