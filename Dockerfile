#Remember that you have TWO directories at play here, the directory you want to specify in the docker container ie WORKDIR
#AND the directory in which this Dockerfile is located, which we refer to by .

FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /usr/share/udemy

#COPY src and pom.xml from the same directory as Dockerfile to a new folder called /usr/share/udemy/src AND /usr/share/udemy respectively.
COPY src ./src
COPY pom.xml .
RUN mvn -f /usr/share/udemy/pom.xml clean package -DskipTests

#AFter we compile the project, our NEW compiled files are stored in "/usr/share/udemy/target"

FROM openjdk:8u191-jre-alpine3.8

#Workspace
WORKDIR /usr/share/udemy

#COPY src files from first image

#ADD .jars under our host target folder into this image

#here we copy files from the build image's target folder into our NEW openjdk image under the directory "/usr/share/udemy"
COPY --from=build /usr/share/udemy/target/selenium-docker.jar selenium-docker.jar
COPY --from=build /usr/share/udemy/target/selenium-docker-tests.jar selenium-docker-tests.jar
COPY --from=build /usr/share/udemy/target/libs lsibs

#ADD target/selenium-docker.jar selenium-docker.jar
#ADD target/selenium-docker-tests.jar selenium-docker-tests.jar
#ADD target/libs libs

#ADD SUITE FILES
#The reason you are ADDing this and not Copying from the first build is because ONLY the source files and pom.xml are in that first "build" ontainer, you don't need to
#copy it, you are already in that directory so you can just ADD it from the current directory into the docker containers working directory.
#As far as I know, this will be the LATEST pulled file, that part is not up to Docker, but it's up to the CI that controls which version of the project it's pulling
ADD rehan-tests.xml rehan-tests.xml

#this entrypoint will run a command in the WORKDIR folder that you specified.
#We're passing environment vriables here, which we will add when we run our container.
ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* -DBROWSER=$BROWSER -DHUB_HOST=$HUB_HOST org.testng.TestNG $MODULE