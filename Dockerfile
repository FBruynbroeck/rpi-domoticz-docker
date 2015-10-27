#
# Dockerfile for Domoticz
#
# Based on version by LBTM
#
# Base image.
FROM resin/rpi-raspbian

MAINTAINER Florian Chauveau

# Install Domoticz from sources.
RUN \
  apt-get update && \
  apt-get install -y cmake apt-utils build-essential && \
  apt-get install -y libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev zlib1g-dev && \
  curl http://domoticz.sourceforge.net/domoticz_linux_armv7l.tgz -o /root/domoticz_linux_armv7l.tgz && \
  tar xvfz /root/domoticz_linux_armv7l.tgz -C /root/domoticz && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/domoticz_linux_armv7l.tgz

# cp database (if present, otherwise gives info message)
ADD domoticz.db /root/domoticz/domoticz.db

# mountable backup dir
VOLUME /root/domoticz/backup

# Expose port.
EXPOSE 8080

#CMD ["service domoticz start"]]
CMD ["/root/domoticz/domoticz", "-www 8080"]
