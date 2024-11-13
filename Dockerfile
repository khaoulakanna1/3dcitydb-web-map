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

COPY /3dwebclient/ /js/ /theme /ThirdParty /ts /docker/* ./

RUN set -ex && \
  ls -lah && \
  npm install --production && \
  chown -R node:node .



# RUN set -x \
#   && BUILD_PACKAGES='ca-certificates git' \
#   && apt-get update && apt-get install -y --no-install-recommends $BUILD_PACKAGES \
#   && git clone -b "${WEBMAPCLIENT_VERSION}" --depth 1 https://github.com/3dcitydb/3dcitydb-web-map.git /var/www \
#   && cd /var/www \
#   && rm -rf ./.git ./.gitignore ./LICENSE ./README.md ./build.xml \
#      ./node_modules ./server.js $(ls -1 --ignore=ajax-loader.gif --ignore=favicon.png \
# 		--ignore=GPS_off.png --ignore=GPS_on.png --ignore=GPS_on_ori.png --ignore=GPS_on_pos_ori.png \
# 		 ./theme/img) \
#   && mkdir -p /var/www/data \
#   && apt-get purge -y --auto-remove $BUILD_PACKAGES \
#   && rm -rf /var/lib/apt/lists/*

# WORKDIR /var/www/
# COPY package.json ./
# COPY html/* ./
# COPY server.js ./
# RUN set -x \
#   && npm install --production

# RUN set -x \
#   &&

USER node
EXPOSE 8000
CMD [ "node", "server.js", "--public"]
