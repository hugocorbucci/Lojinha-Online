#!/usr/bin/env bash

if [[ -z `which mongod` ]]; then
  brew install mongo
fi

bundle install
bundle exec foreman start -f Procfile.dev
