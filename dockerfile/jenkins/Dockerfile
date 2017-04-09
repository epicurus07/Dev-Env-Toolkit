FROM jenkins

USER root
# Upgrade packages on image
RUN apt-get -q update &&\
# install valgrind, gradle, doxygen, graphviz
	DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends valgrind gradle doxygen graphviz &&\
	apt-get -q clean -y && rm -rf /var/lib/apt/lists/* &&\
	rm -f /var/cache/apt/*.bin &&\
# need for sonarqube
	update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java