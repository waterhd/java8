FROM oraclelinux:7.5

LABEL maintainer="Dennis Waterham <dennis.waterham@oracle.com>"

# Define base URL
ARG BASE_URL=http://httpserver:8000

# Set defaults
ARG JAVA_VERSION=8u181
ARG JAVA_FOLDER=jdk1.8.0_181
ARG FILE=server-jre-$JAVA_VERSION-linux-x64.tar.gz
ARG SHA1=ea1e9aa79cb382b787bb24728162ead34ef924f8

# Move into java directory
WORKDIR /usr/java

# Set Java home location
ENV JAVA_HOME=/usr/java/$JAVA_FOLDER

# Update path
ENV PATH=$PATH:$JAVA_HOME/bin

# Install Java
RUN curl -LO# "$BASE_URL/$FILE" \
 && printf "%s *%s\n" $SHA1 $FILE | sha1sum -c \
 && tar xapf $FILE \
 && rm -fv $FILE \
 && ln -s $JAVA_HOME /usr/java/latest \
 && ln -s $JAVA_HOME /usr/java/default \
 && alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 \
 && alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000 \
 && alternatives --install /usr/bin/jar jar $JAVA_HOME/bin/jar 20000

WORKDIR /
