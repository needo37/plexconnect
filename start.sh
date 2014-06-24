#!/bin/bash

# Generate SSL certificates if they don't exist
/bin/bash /sslgen.sh

# Start PlexConnect
/usr/bin/python /opt/plexconnect/PlexConnect.py
