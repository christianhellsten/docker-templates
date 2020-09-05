#!/bin/bash
set -e # Exit on error

cd /app

echo "Running Rails migrations"
bundle exec rake db:migrate
echo "Running Rails data migrations"
bundle exec rake data:migrate

exec bundle exec puma -C config/puma.rb
