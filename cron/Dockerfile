FROM alpine
#
# NOTE: You can also use any of the predefined directories:
#
#  /etc/periodic/15min
#  /etc/periodic/hourly
#  /etc/periodic/daily
#  /etc/periodic/weekly
#  /etc/periodic/monthly
#
# COPY run.sh /etc/periodic/weekly/run

COPY cron /etc/crontabs/root

WORKDIR /app
# USER app
# The hook URL of the Slack channel where notifications will be sent
ENV SLACK_URL
# Curl is only needed for Slack notifications
RUN apk add curl
# RUN apk add vim
#
# NOTE: Add custom cron entries to /etc/crontabs/root
#
# Run cron in foreground with log level 8
CMD ["crond", "-f", "-l", "8"]
