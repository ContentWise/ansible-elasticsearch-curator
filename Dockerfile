FROM ruby:alpine

ARG DOCKER_CLI_VERSION="17.09.0-ce"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  curl \
  && mkdir -p /tmp/download \
  && curl -L $DOWNLOAD_URL | tar -xz -C /tmp/download \
  && mv /tmp/download/docker/docker /usr/local/bin/ \
  && rm -rf /tmp/download \
  && apk del curl \
  && rm -rf /var/cache/apk/*

WORKDIR /workdir
COPY . .
RUN bundle install

ENTRYPOINT ["make"]