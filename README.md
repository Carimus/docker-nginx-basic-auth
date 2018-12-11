# nginx-basic-auth

Simple Docker image to provide basic authentication on top of serving static files.

## Quickstart

To start the container, mounting your current working directory to be served as the root.

```bash
docker run --init -p 8080:80 -v "$(pwd):/var/www/html" carimus/nginx-basic-auth
```

Try accessing and logging in with username `foo` and password `bar` at
[http://localhost:8080](http://localhost:8080).

## Advanced

```bash
docker run --init \
           -e HTPASSWD='foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.' \
           -e ROOT_PATH=/srv/www \
           -e SPA=true \
           -p 8080:80 \
           -v "$(pwd):/srv/www" \
           carimus/nginx-basic-auth
```

> Use single quotes to prevent unwanted interpretation of `$` signs!

## Configuration

 - `HTPASSWD` (default: `foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.`): Will be written to the
   `auth.htpasswd` file on launch (non-persistent)
 - `ROOT_PATH` (default: `/var/www/html`): Absolute path to the directory to serve as the root of
   the server.
 - `SPA` (default: `false`): Set to exactly `true` if you want to have all paths that don't resolve
   to a file, resolve to `index.html`.
   [See this article](https://medium.com/yld-engineering-blog/deploy-your-create-react-app-with-docker-and-ngnix-653e94ffb537)
   for one of many explanations.

## Multiple Users

Multiple Users are possible by separating the users by newline. To pass the newlines properly you
need to use Shell Quoting (like `$'foo\nbar'`):

```bash
docker run --init \
           -e HTPASSWD=$'foo:$apr1$odHl5EJN$KbxMfo86Qdve2FH4owePn.\ntest:$apr1$LKkW8P4Y$P1X/r2YyaexhVL1LzZAQm.' \
           -v "$(pwd):/var/www/html" \
           carimus/nginx-basic-auth
```

results in 2 users (`foo:bar` and `test:test`).

## Troubleshooting

 - SSL is unsupported ATM, but might be available in the near future. For now it might be a
   suitable solution to use another reverse proxy (e.g. `jwilder/nginx-proxy`) that acts as a
   central gateway. You just need to configure the `VIRTUAL_HOST` env and disable port forwarding.

## Updates

The general workflow is as such:

 1. Update the [`Dockerfile.template`](./Dockerfile.template) as necessary.
 2. Run [`update.sh`](./update.sh) to update the alpine-version-specific `Dockerfile`s.
 3. Build and test locally (e.g.
    `docker build -t carimus/nginx-basic-auth/test:latest -f ./alpine-1.15/Dockerfile .`)
 4. Add and commit the changes
 5. Run [`publish.sh`](./publish.sh) to build all images and push them up to docker hub. This will
    overwrite existing images there so be sure the images are backwards compatible.
