#!/bin/bash

set -x
RAILS_ENV=development bundle exec rake db:create db:migrate
RAILS_ENV=development bundle exec rails server
