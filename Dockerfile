FROM nginx:stable-alpine

LABEL Description="Nginx Docker image" \
      Maintainer="Konstantin Kozhin <1387510+kozhin@users.noreply.github.com>" \
      Vendor="CodedRed" \
      Version="0.1.1"

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

# Set Crontab script
RUN crontab -l | { cat; echo "0 0 * * * sh /scripts/renew_certs.sh > /dev/null 2>&1"; } | crontab -

# Set container volumes
VOLUME [ "/etc/nginx", "/etc/letsencrypt" ]

# Expose service ports
EXPOSE 443 80

# Set stop signal
STOPSIGNAL SIGQUIT

# Set execution command
CMD ["nginx", "-g", "daemon off;"]