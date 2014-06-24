#!/bin/bash

# Generate SSL certificates if they don't exist
if [ -f /opt/plexconnect/assets/certificates/trailers.pem ] ; then
  continue
else
  openssl req -new -nodes -newkey rsa:2048 -out /opt/plexconnect/assets/certificates/trailers.pem -keyout /opt/plexconnect/assets/certificates/trailers.key -x509 -days 7300 -subj "/C=US/CN=trailers.apple.com"
  openssl x509 -in /opt/plexconnect/assets/certificates/trailers.pem -outform der -out /opt/plexconnect/assets/certificates/trailers.cer && cat /opt/plexconnect/assets/certificates/trailers.key >> /opt/plexconnect/assets/certificates/trailers.pem
fi

# Start PlexConnect
/usr/bin/python /opt/plexconnect/PlexConnect.py
