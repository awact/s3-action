FROM python:3.7-alpine

LABEL "com.github.actions.name"="S3 Sync"
LABEL "com.github.actions.description"="Sync a Directory to a S3 repository"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.0.1"
LABEL repository="https://github.com/awact/s3-action"
LABEL homepage="https://github.com/awact/s3-action"
LABEL maintainer="Shun Kakinoki @shunkakinoki"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV WORKDIR /app/

WORKDIR ${WORKDIR}

RUN pip install --upgrade pip && pip install pipenv

RUN pipenv install --system --ignore-pipfile --deploy

COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]