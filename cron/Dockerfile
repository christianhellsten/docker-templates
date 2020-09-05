# TODO: Switch to alpine
FROM debian:bullseye-slim

RUN apt-get update -qq && apt-get install -y ca-certificates cron curl
RUN useradd --user-group -m --home /app --shell /bin/false app
RUN chown app:app /app
RUN chmod -R 777 /app

COPY crontab /etc/cron.d/go-13f
COPY entrypoint.sh /entrypoint.sh

# Add cronjobs to app user's crontab
RUN crontab /etc/cron.d/go-13f
RUN touch /var/log/cron.log

WORKDIR /app

# TODO: Figure out how to run non-root
# USER app
COPY --chown=app:app bin/linux/go-13f /app
COPY --chown=app:app .docker/run.sh /app/run.sh
COPY --chown=app:app .docker/entrypoint.sh /app/entrypoint.sh

ENV HOME=/app
ENV PATH=/app:$PATH

# App's ENV
ENV DB_HOST=
ENV DB_NAME=
ENV DB_USER=
ENV DB_PASS=
ENV LOG_DIR=
ENV LOG_LEVEL=

# For debugging
RUN apt install -y vim procps

# For logging
RUN ln -sf /proc/1/fd/1 /var/log/app.log

CMD ["/app/entrypoint.sh"]
