#!/bin/sh

# Update CloudFlare's IP pool
/scripts/cloudflare_update_ip_pool.sh

# Reload nginx to apply new configuration
nginx -s reload

echo "COMPLETED: cloudflare_apply_ip_pool.sh"
exit 0