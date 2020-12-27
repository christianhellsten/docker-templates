FROM python:3.9-slim-buster
# RUN apt-get update && apt-get install -qq -y curl vim cron postgresql-client
RUN pip install --upgrade pip

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY .docker/run.sh /app
COPY .docker/entrypoint.sh /app
COPY .docker/cron /etc/cron.d/app
RUN crontab /etc/cron.d/app

#
# To export from pipenv use:
# pipenv lock --requirements > requirements.txt
#
ADD requirements.txt /app/
COPY . .
RUN pip install -r requirements.txt

ENTRYPOINT ["/app/entrypoint.sh"]
