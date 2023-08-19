FROM elixir:1.15-slim

RUN set -xe \
  && mix local.hex --force \
  && mix local.rebar --force
