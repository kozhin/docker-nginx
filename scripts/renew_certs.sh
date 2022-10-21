#!/bin/sh
#
# NOTE:
# This script is triggered by Cron
# every midnight. You may adjust it in Dockerfile.
#
# Renew all available certificates if expiring
certbot renew --quiet

echo "COMPLETED: renew_certs.sh"
exit 0