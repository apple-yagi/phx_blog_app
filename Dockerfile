FROM elixir:1.12.2

ENV NODE_VERSION 14.x

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash \
  && apt-get install -y nodejs inotify-tools

RUN mix local.hex --force && \
  mix archive.install hex phx_new 1.5.9 --force && \
  mix local.rebar --force

WORKDIR /app