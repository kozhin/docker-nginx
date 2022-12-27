#!/bin/sh

CF_CONFIG='/etc/nginx/conf.d/cloudflare.conf'

function fetch_cloudflare_list() {
  LIST=`curl -s https://www.cloudflare.com/ips-${1}`
  IPS=`echo "$LIST" | awk '{ print $1 }'`
  for IP in ${IPS[@]}
  do
    echo "set_real_ip_from ${IP};" >> $CF_CONFIG
  done
}

TIMESTAMP=`date`
echo "\n# Automatically updated at ${TIMESTAMP}" > $CF_CONFIG

echo "\n# https://www.cloudflare.com/ips-v4\n" >> $CF_CONFIG
fetch_cloudflare_list 'v4'

echo "\n# https://www.cloudflare.com/ips-v6\n" >> $CF_CONFIG
fetch_cloudflare_list 'v6'

echo "\n# Enable real IP from IPs above\n" >> $CF_CONFIG
echo "real_ip_header CF-Connecting-IP;" >> $CF_CONFIG
echo "# real_ip_header X-Forwarded-For; # this is optional and must be used separately from directive above" >> $CF_CONFIG

echo "COMPLETED: cloudflare_update_ip_pool.sh"
exit 0