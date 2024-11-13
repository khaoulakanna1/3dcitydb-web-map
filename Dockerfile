# 3DCityDB Web Map Client Dockerfile ##########################################
#   Official website    https://www.3dcitydb.net
#   GitHub              https://github.com/3dcitydb/3dcitydb-web-map
###############################################################################

# Base image
ARG BASEIMAGE_TAG='21-bookworm'
FROM "node:${BASEIMAGE_TAG}"

# Setup 3DCityDB Web Map Client ###############################################
RUN set -ex \
  mkdir -p /var/www /var/www/data

WORKDIR /var/www

COPY /3dwebclient ./3dwebclient
COPY /js ./js
COPY /theme ./theme
COPY /ThirdParty ./ThirdParty
COPY /docker/package.json  /docker/server.js /docker/html/ ./

RUN set -ex && \
  npm install --omit=dev && \
  chown -R node:node .

USER node
EXPOSE 8000
CMD [ "node", "server.js", "--public"]
