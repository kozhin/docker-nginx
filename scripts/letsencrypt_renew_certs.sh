#!/bin/sh
#
# NOTE:
# This script is triggered by Cron
# every midnight. You may adjust it in Dockerfile.
#
# Renew all available certificates if expiring
certbot renew --quiet

# Reload nginx to apply new configuration
nginx -s reload

echo "COMPLETED: letsencrypt_renew_certs.sh"
exit 0