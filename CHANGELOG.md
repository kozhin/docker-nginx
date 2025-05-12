
# Changelog

=====================
## [0.6.1] 13/05/2025 - `Nginx`: Nginx upgrade to 1.28.0

Changes:
1. Switched to Nginx 1.28.0

=====================
## [0.6.0] 24/12/2024 - `Nginx`: Nginx upgrade to 1.26.2

Changes:
1. Switched to Nginx 1.26.2
2. Added entrypoint script
3. Added cron support
4. Makefile updated: deploy added
5. Switched to GitHub registry

=====================
## [0.5.0] 10/06/2024 - `Nginx`: Nginx upgrade to 1.26.1

Changes:
1. Switched to Nginx 1.26.1

=====================
## [0.4.0] 19/05/2024 - `Nginx`: Nginx upgrade to 1.26.0

Changes:
1. Switched to Nginx 1.26.0
2. LE renewal script update

=====================
## [0.3.3] 13/11/2023 - `Updates & Fixes`: .dockerignore

Changes:
1. .dockerignore added
2. acl.conf added
3. default.conf updated

=====================
## [0.3.2] 13/04/2023 - `Nginx update`: Nginx 1.24.0

Changes:
1. Nginx updated to 1.24.0

=====================
## [0.3.1] 31/03/2023 - `Nginx & LE update`: Nginx reload on certs renewal

Changes:
1. Nginx reload after LE renewal daily added

=====================
## [0.3.0] 27/12/2022 - `CloudFlare support`: Real IP passing to nginx

Changes:
1. CloudFlare configuration added
2. Some automation for acquiring CloudFlare IP addresses and passing to nginx
3. New cron job to sync CloudFlare IPs monthly
4. Renamed Let's Encrypt related scripts

=====================
## [0.2.1] 20/11/2022 - `Minor fix`: Docker compose config fix

Changes:
1. docker-compose.example.yaml fix

=====================
## [0.2.0] 03/11/2022 - `Improvements`: Health checks feature

Changes:
1. Health checks added. See docker-compose.example.yaml
2. Latest tag added

=====================
## [0.1.1] 29/10/2022 - `Documentation`: README.md updates and many more

Changes:
1. README.md updated
2. Comments and examples added to other files and scripts

=====================
## [0.1.0] 21/10/2022 - `Adding Basic Stuff`: Bare minimum

Changes:
0. VERSION and CHANGELOG created
1. Added many files :)
2. Dockerfile added
3. Certbot scripts added
4. Cron added
5. Upstreams support added
