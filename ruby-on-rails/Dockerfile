#
# Ruby on Rails Dockerfile
#
# ## Features:
#
# - Ruby
# - Puma
# - Yarn
# - Node
# - PostgreSQL
#
# ## Configuration
#
# ```bash
# mkdir .docker
# cat << EOF > .docker/envrc.dev
# RAILS_ENV=development
# DB_HOST=docker.for.mac.localhost
# # Alternatively:
# # DB_HOST=localhost
# DB_NAME=app_development
# DB_USER=app
# DB_PASS=password
# EOF
# cat << EOF > .docker/envrc.prod
# RAILS_ENV=production
# DB_HOST=postgres
# DB_NAME=app_production
# DB_USER=app
# DB_PASS=password
# EOF
# ```
#
# ## Usage
#
# ```bash
# $ docker build . -t <image name>
#
# # Development
# $ docker run -p 3000:3000 --env-file=.docker/envrc.dev <image name>
#
# # Alternatively:
# $ docker run --network=host --env-file=.docker/envrc.dev <image name>
#
# # Production
# $ docker run -p 3000:3000 --env-file=.docker/envrc.prod <image name>
# ```

#
# BASE: shared environment variables, etc.
#
FROM ruby:2.6.3-alpine AS base

WORKDIR /app/
EXPOSE 3000

ENV PORT 3000
ENV LANG C.UTF-8
ENV BUNDLE_APP_CONFIG /app/.bundle
ENV BUNDLE_BIN /app/vendor/bundle/bin
ENV BUNDLE_PATH /app/vendor/bundle
ENV GEM_HOME /app/vendor/bundle
ENV PATH "/app/vendor/bundle/bin:/app/node_modules/.bin:${PATH}"

# Set working dir
ENV RAILS_ROOT /app

ARG RAILS_ENV=production
ARG DB_HOST
ARG DB_NAME
ARG DB_USER
ARG DB_PASS

# Set ENV variables
ENV RAILS_ENV ${RAILS_env}
ENV RACK_ENV ${RAILS_ENV}
ENV DB_HOST ${DB_HOST}
ENV DB_NAME ${DB_NAME}
ENV DB_USER ${DB_USER}
ENV DB_PASS ${DB_PASS}
ENV RAILS_LOG_TO_STDOUT true

# Add aliases
RUN echo "export LS_OPTIONS='--color=auto'" >> "$HOME/.bashrc" \
    && echo "alias ls='ls $LS_OPTIONS'" >> "$HOME/.bashrc" \
    && echo "alias ll='ls $LS_OPTIONS -l'" >> "$HOME/.bashrc" \
    && echo "alias l='ls $LS_OPTIONS -lA'" >> "$HOME/.bashrc" \
    && echo "alias console='bundle exec rails console'" >> "$HOME/.bashrc" \
    && echo "gem: --no-rdoc --no-ri" > "$HOME/.gemrc"

# TODO: Add ARG RUNTIME_DEPS
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache \
    bash \
    postgresql-dev

FROM base AS builder

# TODO: Add ARG BUILD_DEPS
RUN apk add --update --no-cache \
    build-base curl-dev git postgresql-dev \
    yaml-dev zlib-dev nodejs yarn

#
# BUILDER: install and cache Ruby & Javascript dependencies
#
FROM builder AS ruby
ENV RAILS_ENV=production

#
# RUBY
#
# Add and cache Ruby dependencies
COPY Gemfile Gemfile.lock /app/
# Install Ruby and Javascript dependencies
RUN gem install --force bundler rake && \
  bundle config set without development test && \
  bundle config set --local deployment 'true' && \
  bundle install --jobs 10 --retry 5 && \
  bundle clean --force

#
# ASSETS
#
FROM builder AS assets
ENV RAILS_ENV=production

# Add and cache Javascript dependencies
COPY package.json yarn.lock ./

# Install Javascript dependencies
RUN yarn install

# Copy Ruby dependencies
COPY --from=ruby /app/ /app/
# Copy rest of application
COPY . /app

# Precompile assets
RUN bundle exec rake DATABASE_URL=postgresql:does_not_exist assets:precompile

#
# CLEAN UP
#
RUN rm -rf app/assets node_modules log tmp \
    && mkdir -p log tmp/pids

#
# FINAL
#
FROM base

#
# NOTE: Don't run as root
#
# Debian:
# RUN useradd --user-group -m --home /app --shell /bin/false app
RUN addgroup -S app && adduser -S app -G app && chown -R app /app/ && chgrp -R app /app/ && chmod -R 740 /app/

USER app

COPY --chown=app:app --from=assets /app/ /app/
COPY --chown=app:app entrypoint.sh /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
