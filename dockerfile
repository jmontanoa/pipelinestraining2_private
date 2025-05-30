# syntax=docker/dockerfile:1
ARG BASE_IMAGE=python:3.13-alpine
FROM ${BASE_IMAGE} as common
WORKDIR /code
ENV FLASK_APP=restApp/__init__.py
ENV FLASK_RUN_HOST=0.0.0.0

FROM common AS image-setup
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000

FROM common AS final-setup
# only used when building from python base image(e.g python:3.13-alpine)
COPY --from=image-setup /root/.cache/pip /root/.cache/pip
COPY . .
CMD ["flask", "run"]

FROM common AS final-base
# only used when building from restapp base image(e.g restapp:1.0.0)
COPY . .
CMD ["flask", "run"]
