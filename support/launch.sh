#!/bin/sh

rm -rf /etc/nginx/conf.d/default.conf

if [[ "$SPA" == "true" ]]; then
  export NGINX_CONF_INCLUDE="include /opt/spa.conf;"
else
  export NGINX_CONF_INCLUDE="include /opt/non-spa.conf;"
fi

envsubst < auth.conf > /etc/nginx/conf.d/default.conf
envsubst < auth.htpasswd > /etc/nginx/auth.htpasswd

exec nginx -g "daemon off;"
