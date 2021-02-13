#!/usr/bin/env bash
HOME=/app
USER=app
# NOTE: Specify the full path to Python to avoid version conflicts and issues with e.g. cron
/usr/local/bin/python3 -m scripts.do_it
