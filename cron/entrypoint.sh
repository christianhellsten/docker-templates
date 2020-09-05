#!/usr/bin/env bash
echo "Starting cron..."
printenv | grep -v "no_proxy" >> /etc/environment
cron -f
