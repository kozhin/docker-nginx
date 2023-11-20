
# Read Me

## Why

Very often one machine hosts multiple Docker containers with multiple web services requiring access via common protocols (HTTP/HTTPS) from the public Internet. Such services can't acquire ports 80 and 443 simultaneously on one machine. This Docker image helps to create a container with Nginx to proxy requests from external clients to internal containers using internal ports.

In addition, this image includes Let's Encrypt's Certbot which allows to create and manage free SSL certificates. Auto-renewal feature is included.

## What's inside

### Software

Alpine Linux + Nginx + Certbot + Cronie + a bunch of shell scripts (see folder `scripts`).

### Supported architectures:

- amd64
- arm64

### Versioning

Docker images available at [https://hub.docker.com](https://hub.docker.com) have tags which correspond to installed versions of Nginx. This means that image `kozhin/docker-nginx:1.22.1` has Nginx `1.22.1` inside. Versions of Certbot and other packages are expected to be latest to the moment of image creation (see image creation date).

### Host machine requirements

- Latest Docker installed
- Docker Compose available

## How To Use

To use this Docker image some manual configuration is required.

### First Run

1. Copy `docker-compose.example.yaml` to any folder on your host machine, e.g. `/apps`
2. Adjust file for your needs and rename it to `docker-compose.yaml`
3. Run `docker compose up -d`
4. Open `http://YOUR_IP_ADDRESS/` in browser. If all goes well, you will see 404 error

### Adding a new virtual host

1. Add new services to `docker-compose.yaml` (examples included)
2. Spin up a new services with `docker compose up -d` and make sure they are up and running on specific ports
3. Exec to the running container `web`: `docker exec -it web sh`
4. Open `/etc/nginx/conf.d/default.conf` and add new virtual host for you domain name using example in the file
5. Open `/etc/nginx/conf.d/upstreams.conf`
6. Add a new virtual host by creating new `upstream` directive with required virtual host name like `www.example.com`
7. Point new upstream to a container for a service using internal port
8. Verify nginx configuration with `nginx -T`
9. Reload nginx configuration with `nginx -s reload`
10. Point your domain name to the created virtual host and wait DNS to propagate

### Creating SSL certificates

1. Exec to running container `web`: `docker exec -it web sh`
2. Remove your virtual host from `/etc/nginx/conf.d/default.conf` if exists, so Certbot could manage this for you
3. Adjust and run `/scripts/letsencrypt_add_cert.sh`
4. Open `/etc/nginx/conf.d/default.conf` and add the following line to virtual host's `server` section with SSL: `include /etc/nginx/conf.d/upstream.conf;`
5. Verify nginx configuration with `nginx -T`
6. Reload nginx configuration with `nginx -s reload`
7. Check that your new virtual host is accessible using HTTPS

### SSL certificates auto-renewal

This is handled automatically on a daily basis for all certificates. If you need to adjust time of certificates checkup:

1. Exec to running container `web`: `docker exec -it web sh`
2. Run `crontab -e` command
3. Modify the schedule and save changes

### Real IP support for CloudFlare

When nginx stands behind CloudFlare it can't properly acquire IP addresses of clients connecting to web apps. To solve this issue:

1. Exec to running container `web`: `docker exec -it web sh`
2. Uncomment line with CloudFlare config (L66) in `/etc/nginx/nginx.conf`
3. Reload nginx with `nginx -s reload`

### Shutting down

Simply run the following commands from your folder with `docker-compose.yaml` file:

1. `docker compose stop`
2. `docker compose rm`

NOTE: container volumes will be preserved with all data inside. To delete them use `docker volume rm %VOLUME NAMES%`. Also you may want to remove networks with `docker network rm %NETWORK NAMES%`

### Updating everything

1. Use steps mentioned in `Shutting down` section
2. Then run `docker compose pull`
3. And finally `docker compose up -d`

NOTE: use `docker image prune` to remove unused images. BE CAREFUL! This command may remove other unused images.

### How to remove a virtual host for a domain name

1. Remove certificate from the container (`docker exec -it web sh`): `certbot delete --cert-name example.com`
2. Remove virtual host upstream from `conf.d/upstreams.conf`
2. Check `conf.d/default.conf` and remove unnecessary virtual host

## License

MIT
