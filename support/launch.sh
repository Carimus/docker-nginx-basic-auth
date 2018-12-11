#!/bin/sh

rm -rf /etc/nginx/conf.d/default.conf
envsubst < auth.conf > /etc/nginx/conf.d/default.conf
envsubst < auth.htpasswd > /etc/nginx/auth.htpasswd

nginx -g "daemon off;"
