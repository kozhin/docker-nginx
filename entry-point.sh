#!/bin/sh

# Start cron server
crond

# Start webpserver
nginx -g "daemon off;"
