# NGINX Domain Redirect #

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/vktrl/nginx-domain-redirect) ![Docker Pulls](https://img.shields.io/docker/pulls/vktrl/nginx-domain-redirect)

All this lightweight Docker image does is redirect all requests from `[www.]olddomain.com` to `https://www.newdomain.com`

## What? ##
- Tiny image, about 23MB
- Configurable listening port, defaults to 80
- Logging to stdout with helpful fields, ready for Stackdriver/Cloudwatch
- Redirect using `return` vs `rewrite` for faster execution
- Configurable HTTP status, defaults to 301
- Paths are preserved: `htp://www.old.com/blog/article` will be redirected to `https://www.new.com/blog/article`

## How? ##
### docker-compose ###

```yaml
services:
  redirect:
    image: vktrl/nginx-domain-redirect
    restart: always
    environment:
      - OLD_DOMAIN=foo.com
      - NEW_DOMAIN=bar.com
      - PORT= # optional, defaults to 80
      - HTTP_STATUS= # optional, defaults to 301
```

### Docker ###

**Using settings file:**

`docker run --rm -d --env-file settings.env -p 80:80 vktrl/nginx-domain-redirect`

**Using inline variables:**

`docker run --rm -d -e OLD_DOMAIN=foo.com -e NEW_DOMAIN=bar.com -p 80:80 vktrl/nginx-domain-redirect`

## HTTPS/SSL ##

For SSL termination and/or running nginx-domain-redirect side-by-side, you can use
- [nginx-proxy](https://github.com/jwilder/nginx-proxy) with [letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)
- [Traefik](https://github.com/containous/traefik)
- [GCP LB](https://cloud.google.com/load-balancing/)
- [AWS ELB](https://aws.amazon.com/blogs/aws/elastic-load-balancer-support-for-ssl-termination/)

## Notes ##
- I'll will redirect to **https:// only**
- It assumes that you're using www
-

Modify accordingly if it doesn't fit your needs
