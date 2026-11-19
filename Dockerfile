FROM nginx:1.30.7-alpine

# Take Alpine 3.24's pending package fixes at build time; the stable branch ships only fixes. On 19 November 2026 that was
# libssl3/libcrypto3 3.5.9-r1 and zlib 1.4-r0. nginx 1.30.7's image already carries brotli-libs 1.2.1-r0 (CVE-2026-111497),
# so the targeted brotli upgrade is gone. Monorepo issue #3216.
RUN apk upgrade --no-cache

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
