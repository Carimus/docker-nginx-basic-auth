FROM nginx:1.15-alpine

WORKDIR /opt

ENV HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
    ROOT_PATH=/var/www/html \
    SPA=false

RUN mkdir -p /var/www/html || true

RUN apk add --no-cache gettext

COPY support/ ./

CMD ["./launch.sh"]
