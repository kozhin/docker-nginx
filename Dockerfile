FROM nginx:stable-alpine

LABEL Description="Nginx Docker image" \
      Maintainer="Konstantin Kozhin <1387510+kozhin@users.noreply.github.com>" \
      Vendor="" \
      Version="0.3.0"

# Install necessary packages
RUN apk update && \
    apk add --no-cache certbot certbot-nginx cronie && \
    mkdir -p /etc/letsencrypt && \
    mkdir -p /scripts

# Set working folder
WORKDIR /etc/nginx

# Copy Nginx configuration and Certbot scripts
COPY nginx/nginx.conf .
COPY conf/*.conf ./conf.d/
COPY scripts/*.sh /scripts/

# Sync CloudFlare IP addresses pool
RUN /scripts/cloudflare_update_ip_pool.sh

# Set Crontab scripts
RUN crontab -l | { cat; echo "0 0 * * * sh /scripts/letsencrypt_renew_certs.sh > /dev/null 2>&1"; } | crontab -
RUN crontab -l | { cat; echo "0 0 1 * * sh /scripts/cloudflare_apply_ip_pool.sh > /dev/null 2>&1"; } | crontab -

# Set container volumes
VOLUME [ "/etc/nginx", "/etc/letsencrypt" ]

# Expose service ports
EXPOSE 443 80

# Set stop signal
STOPSIGNAL SIGQUIT

# Set execution command
CMD [ "nginx", "-g", "daemon off;" ]
