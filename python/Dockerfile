FROM python:3.9-slim-buster
# Locale
RUN apt-get update && \
    apt-get install -qq -y locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN dpkg-reconfigure --frontend=noninteractive locales

# RUN apt-get update && apt-get install -qq -y curl vim cron postgresql-client
RUN pip install --upgrade pip

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY .docker/run.sh /app
COPY .docker/entrypoint.sh /app
COPY .docker/cron /etc/cron.d/app
RUN crontab /etc/cron.d/app

# Add user
RUN addgroup -S app && adduser --uid 10000 --gid 10001 -S app -G app && chown -R app /app/ && chgrp -R app /app/ && chmod -R 740 /app/

#
# To export from pipenv use:
# pipenv lock --requirements > requirements.txt
#
# Cache dependencies in a separate layer to avoid reinstallation
ADD requirements.txt /app/
RUN pip install -r requirements.txt

# Copy rest of application
COPY --chown=app:app . .

USER app

ENTRYPOINT ["/app/entrypoint.sh"]
