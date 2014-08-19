FROM phusion/baseimage:0.9.11
MAINTAINER needo <needo@superhero.org>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN apt-get update -q

# Install Dependencies
RUN apt-get install -qy python wget

# Install PlexConnect v0.4
RUN mkdir /opt/plexconnect
RUN wget https://github.com/iBaa/PlexConnect/archive/v0.4.tar.gz
RUN tar -C /opt/plexconnect -xvf /tmp/v0.4.tar.gz --strip-components 1
RUN chown nobody:users /opt/plexconnect

EXPOSE 80

# Add edge.sh to execute during container startup
RUN mkdir -p /etc/my_init.d
ADD edge.sh /etc/my_init.d/edge.sh
RUN chmod +x /etc/my_init.d/edge.sh

# Add PlexConnect to runit
RUN mkdir /etc/service/plexconnect
ADD plexconnect.sh /etc/service/plexconnect/run
RUN chmod +x /etc/service/plexconnect/run
