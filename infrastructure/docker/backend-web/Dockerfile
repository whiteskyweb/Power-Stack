ARG NGINX_VER=1.15
FROM nginx:${NGINX_VER}-alpine

ARG API_HOST=api.localhost
ARG ENV=local


# install the packages we need
RUN apk add --no-cache gettext

# Copy across any custom php.ini files
COPY ./infrastructure/configuration/nginx/ /etc/nginx/conf.d/

RUN envsubst '$${HOST},$${API_HOST}, $${ENV}' < /etc/nginx/conf.d/backend-site.conf.template > /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /var/www/web