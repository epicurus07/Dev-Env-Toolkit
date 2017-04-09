FROM redmine

RUN apt-get -q update &&\
# install unzip
	DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends unzip darcs cvs &&\
	apt-get -q clean -y && rm -rf /var/lib/apt/lists/* &&\
	rm -f /var/cache/apt/*.bin 

COPY files/docker-entrypoint.sh /
COPY files/docker-custompoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
