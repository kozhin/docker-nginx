#!/bin/sh

CF_CONFIG='/etc/nginx/conf.d/cloudflare.conf'
TIMESTAMP=$(date)

echo -e "\n# Automatically updated on ${TIMESTAMP}" > $CF_CONFIG

URL='https://www.cloudflare.com/ips-v4'

echo -e "\n# ${URL}\n" >> $CF_CONFIG
LIST=$(curl -s ${URL})
IPS=$(echo "$LIST" | awk "{ print $1 }")
IPS=$(echo "${IPS}" | tr "\n" "|")
while [ -n "$IPS" ]; do IP=${IPS%%|*}; echo "set_real_ip_from ${IP};" >> $CF_CONFIG; IPS=${IPS#*|}; done
unset IP IPS LIST URL

URL='https://www.cloudflare.com/ips-v6'

echo -e "\n# ${URL}\n" >> $CF_CONFIG
LIST=$(curl -s ${URL})
IPS=$(echo "$LIST" | awk "{ print $1 }")
IPS=$(echo "${IPS}" | tr "\n" "|")
while [ -n "$IPS" ]; do IP=${IPS%%|*}; echo "set_real_ip_from ${IP};" >> $CF_CONFIG; IPS=${IPS#*|}; done
unset IP IPS LIST URL

echo -e "\n# Enable real IP from IPs above\n" >> $CF_CONFIG
echo "real_ip_header CF-Connecting-IP;" >> $CF_CONFIG
echo "# real_ip_header X-Forwarded-For; # this is optional and must be used separately from directive above" >> $CF_CONFIG

echo "COMPLETED: cloudflare_update_ip_pool.sh"
exit 0