#!/usr/bin/env bash

# TODO: Replace with the cron command you want to run
echo "it works"

if [ $? -eq 0 ]
then
  echo "Ran cron job successfully"
  exit 0
else
  # TODO: Replace this with a Slack hook URL to get notified of exceptions
  curl -X POST -H 'Content-type: application/json' --data '{"text":"Allow me to reintroduce myself!"}' https://hooks.slack.com/<LOL>
  exit 1
fi

