#!/usr/bin/env bash

# TODO: Replace this line with the cron command you want to run. Remember to
# write stdout and stderr to the log file.
echo "it works" &> /var/log/app.log

if [ $? -eq 0 ]
then
  curl -X POST -H 'Content-Type: application/json' --data "{\"text\":\"Ran cron job successfully: $(tail -n 5 /var/log/app.log)\"}" $SLACK_URL
  exit 0
else
  curl -X POST -H 'Content-Type: application/json' --data "{\"text\":\"Failed to run cron job: $(tail -n 1 /var/log/app.log)\"}" $SLACK_URL
  exit 1
fi
