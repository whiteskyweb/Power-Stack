FROM nginx:1.15-alpine

ARG HOST=localhost
ARG ENV=local

# install the packages we need
RUN apk add --no-cache gettext

# Copy across any custom php.ini files
COPY ./infrastructure/configuration/nginx/ /etc/nginx/conf.d/

RUN envsubst '$${HOST}, $${ENV}' < /etc/nginx/conf.d/site.conf.template > /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /var/www/web