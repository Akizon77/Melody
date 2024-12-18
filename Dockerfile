FROM python:3.9-slim

ARG VERSION=v1.0
ARG TELEGRAM_BOT_TOKEN

LABEL maintainer="Jeromeliaya <20josemespitia@gmail.com>"
LABEL repository="https://github.com/good-girls/Melody"
LABEL version=$VERSION

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

RUN if ! command -v curl >/dev/null 2>&1; then \
    apt-get update && apt-get install -y curl; \
fi

ENV GIN_MODE=release
ENV TELEGRAM_BOT_TOKEN=$TELEGRAM_BOT_TOKEN

WORKDIR /Melody

COPY . /Melody

RUN curl -O https://raw.githubusercontent.com/good-girls/Melody/main/Melody.py \
    && pip install --no-cache-dir python-telegram-bot --upgrade \
    && pip install --no-cache-dir "python-telegram-bot[job-queue]"

CMD ["python", "Melody.py"]