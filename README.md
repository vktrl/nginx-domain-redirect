# NGINX Domain Redirect #

![Docker Build Status](https://img.shields.io/docker/build/vktrl/nginx-domain-redirect) ![Docker Pulls](https://img.shields.io/docker/pulls/vktrl/nginx-domain-redirect)

All this lightweight Docker image does is redirect all requests from `[www.]olddomain.com` to `https://www.newdomain.com`

## What? ##
- It's tiny, built on Alpine
- Configurable port (defaults to 80)
- Logging to stdout, ready for Stackdriver/Cloudwatch
- Permanent 301 redirect using `return` vs `rewrite` for faster execution
- Paths are preserved: `htp://www.old.com/blog/article` will be redirected to `https://www.new.com/blog/article`

## How? ##
### docker-compose ###

```yaml
services:
  redirect:
    image: vktrl/nginx-domain-redirect
    restart: always
    environment:
      - OLD_DOMAIN=yes.com
      - NEW_DOMAIN=hello.com
      - PORT= # optional, defaults to 80
```

### Docker ###

`docker run --rm -d --env-file settings.env -p 80:80 vktrl/nginx-domain-redirect`

## Notes ##
- I'll will redirect to **https:// only**
- It assumes that you're using www

Modify accordingly if it doesn't fit your needs
