ARG NGINX_VER=1.15
FROM nginx:${NGINX_VER}-alpine

ARG HOST=localhost
ARG API_HOST=api.localhost
ARG ENV=local

# install the packages we need
RUN apk update && \
    apk add --no-cache gettext \
                       nodejs \
                       nodejs-npm

# Copy across any codebase
COPY ./frontend-code/ /var/www/

WORKDIR /var/www/

RUN npm install && \
    npm install --global gatsby-cli && \
    gatsby build

# Copy across any custom php.ini files
COPY ./infrastructure/configuration/nginx/ /etc/nginx/conf.d/

RUN envsubst '$${HOST}, $${API_HOST}, $${ENV}' < /etc/nginx/conf.d/frontend-site.conf.template > /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
