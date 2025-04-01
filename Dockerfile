FROM ruby:3.3.5-slim AS base

RUN apt-get update -qq \
  && apt-get -yq --no-install-recommends install \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    tzdata \
    curl

# timezone
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# libvips and imagemagick
RUN apt-get -yq --no-install-recommends install \
    libvips-dev \
    imagemagick

# set folder
WORKDIR /app

FROM base AS builder
RUN apt-get update -qq && \
  apt-get -yq --no-install-recommends install git \
  && apt-get clean
RUN gem install bundler -v "$(grep "BUNDLED WITH" Gemfile.lock | tail -1 | awk '{print $3}')"
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application
COPY . .

# Compile assets
# RUN rails assets:precompile

FROM base AS app
# set folder
WORKDIR /app

# Copy gems
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app
# Remove unwanted file
RUN rm -rf /app/node_modules

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]