# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.8
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /app

ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT=""

# Throw-away build stage to reduce final image size
FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config libyaml-dev


COPY Gemfile ./

RUN chmod -R 777 /usr/local/bundle

RUN bundle config set frozen false && bundle install

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

# Final image
# Final image
FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /app && \
    chown -R rails:rails /usr/local/bundle  # ✅ Thêm dòng này để cấp quyền cho user rails

USER rails

WORKDIR /app

CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bin/rails server -b 0.0.0.0 -p 3000"]

