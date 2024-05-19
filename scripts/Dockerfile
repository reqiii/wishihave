FROM jwilder/dockerize

# Установка необходимых утилит
RUN apk update && apk add --no-cache curl jq

COPY dockerize-init.sh /scripts/dockerize-init.sh
RUN chmod +x /scripts/dockerize-init.sh
