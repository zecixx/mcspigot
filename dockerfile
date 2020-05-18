FROM alpine
MAINTAINER tecrist <kyle@tecrist.com>
RUN addgroup -g 1000 mcuser && \
	adduser -D -u 1000 -G mcuser mcuser && \
	mkdir -m 777 /out && \
	chown -R mcuser:mcuser /out
VOLUME /out
RUN apk update && \
        apk add openjdk8 tini wget git
RUN mkdir /buildtools && \
	cd buildtools && \
	wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
	java -jar BuildTools.jar && \
	ls
RUN mkdir /minecraft && \
	cp /buildtools/*.jar /minecraft
ADD mcstarter.sh /minecraft
RUN rm -rf buildtools/ 
WORKDIR /out
USER mcuser
ENTRYPOINT ["tini","--"]
CMD ["/bin/sh","/minecraft/mcstarter.sh"]
EXPOSE 25565

