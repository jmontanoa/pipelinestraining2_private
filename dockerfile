# syntax=docker/dockerfile:1
ARG BASE_IMAGE=base:1.0.0
ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-alpine AS base
# only used when building restapp base image (e.g --target base)
WORKDIR /code
ENV FLASK_APP=restApp/__init__.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000

FROM ${BASE_IMAGE} AS final
# only used when building from restapp base image(e.g BASE_IMAGE=restapp:1.0.0 --target final)
COPY . .
CMD ["flask", "run"]
