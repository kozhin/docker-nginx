#!/bin/sh
#
# NOTE:
# Update DOMAIN variable below
# before running this script.
#
DOMAIN="example.com"
EMAIL="noc@${DOMAIN}"

# Request a new certificate from Let's Encrypt
certbot -n \
  -d ${DOMAIN} \
  -d www.${DOMAIN} \
  -m ${EMAIL} \
  --nginx \
  --agree-tos

# Apply new certificate to Nginx configuration
nginx -s reload

echo "COMPLETED: letsencrypt_add_cert.sh"
exit 0