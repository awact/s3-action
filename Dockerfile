# References:
# https://github.com/anibali/docker-pytorch/blob/master/cuda-10.0/Dockerfile
# https://github.com/pypa/pipenv/blob/master/Dockerfile

# Base Image CUDA
FROM nvidia/cuda:10.0-base-ubuntu18.04

# Install Basic Utilities
RUN apt-get update \
    && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    libffi-dev \
    software-properties-common \
    && add-apt-repository ppa:jonathonf/python-3.7 \
    && rm -rf /var/lib/apt/lists/*

# Install Python3.6
RUN apt-get update \
    && apt-get install -y \
    python3.7 \
    python3.7-dev \
    python3-pip

# Add Backwards Compatibility
RUN rm -rf /usr/bin/python3 && ln /usr/bin/python3.7 /usr/bin/python3

# Set Env Variables
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install Pip3 Pipenv
RUN pip3 install pipenv

# Create a `app` Working Directory
RUN mkdir /app
WORKDIR /app

# Copying Pipfile & Pipfile.lock
COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock

# Install Dependencies
RUN set -ex && pipenv sync --dev
