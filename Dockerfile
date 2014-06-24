FROM debian:jessie
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN apt-get update -q

# Install Dependencies
RUN apt-get install -qy python wget

# Install PlexConnect 2014-06-05
RUN mkdir /opt/plexconnect
RUN wget https://github.com/iBaa/PlexConnect/tarball/d67cf62c16114ba744216449e95378189aad1629 -O /tmp/iBaa-PlexConnect-d67cf62c16.tar.gz
RUN tar -C /opt/plexconnect -xvf /tmp/iBaa-PlexConnect-d67cf62c16.tar.gz --strip-components 1
RUN chown nobody:users /opt/plexconnect

# Generate SSL certificates if they don't exist
ADD sslgen.sh /sslgen.sh

EXPOSE 80

# PlexConnect must be ran as root
ADD start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
