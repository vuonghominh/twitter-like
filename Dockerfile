FROM elixir:latest

ENV APP_HOME /app

WORKDIR $APP_HOME
COPY . $APP_HOME

RUN mix local.hex --force && mix local.rebar --force && mix do deps.get, deps.compile, compile