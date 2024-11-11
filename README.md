# nginx-base

Base NGINX docker container image with support for token replacement in public directory

## Description

The image is based on the official NGINX image and adds a script to replace tokens in the public directory.

By default the location of the public directory is `/usr/share/nginx/html`. Alternatively, the location can be set using the `FILES_DIR` environment variable. The script will be executed at build time and will replace all tokens surrounded with triple underscores `___` in the files directory.

When using this image as a base, it is also possible to execute the token replacement script at runtime to alter additional files (e.g. through provided environment variables) by calling `RUN /usr/local/bin/tokenSubstitute.sh`. in the dockerfile.

### Pull Command

```bash
docker pull ghcr.io/tamugeoinnovation/nginx-base:latest
```
