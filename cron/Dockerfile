FROM alpine
#
# NOTE: Run the script weekly. Use any of the predefined directories for other options:
#
#  /etc/periodic/15min
#  /etc/periodic/hourly
#  /etc/periodic/daily
#  /etc/periodic/weekly
#  /etc/periodic/monthly
#
COPY run.sh /etc/periodic/weekly/run.sh
WORKDIR /app
# USER app
# The hook URL of the Slack channel where notifications will be sent
ENV SLACK_URL
# For debugging etc
# RUN apk add curl vim
#
# NOTE: Add custom cron entries to /etc/crontabs/root
