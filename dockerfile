# syntax=docker/dockerfile:1
ARG BASE_IMAGE=python:3.13-alpine
#ARG BASE_IMAGE=restapp:1.0.0
FROM ${BASE_IMAGE} AS common

FROM common AS image-setup
# only used when building from python base image(e.g BASE_IMAGE=python:3.13-alpine)
WORKDIR /code
ENV FLASK_APP=restApp/__init__.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000

FROM common AS final
# only used when building from restapp base image(e.g BASE_IMAGE=restapp:1.0.0)
COPY . .
CMD ["flask", "run"]
