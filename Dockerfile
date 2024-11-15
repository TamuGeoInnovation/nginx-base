FROM nginx:1.23.2-alpine

ONBUILD ARG GIT_TAG
ONBUILD ARG GIT_COMMIT
ONBUILD ARG BUILD_DATE

# Set ARGs as ENV variables
ONBUILD ENV GIT_TAG=${GIT_TAG}
ONBUILD ENV GIT_COMMIT=${GIT_COMMIT}
ONBUILD ENV BUILD_DATE=${BUILD_DATE}
ONBUILD ENV FILES_DIR=/usr/share/nginx/html

RUN apk add --no-cache bash

# Copy substitution script
COPY --chmod=0755 tokenSubstitute.sh /usr/local/bin/tokenSubstitute.sh

# Copy a new entrypoint script that will run only at runtime
COPY --chmod=0755 entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the new entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
