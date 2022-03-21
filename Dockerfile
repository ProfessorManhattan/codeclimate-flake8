FROM python:alpine AS codeclimate

WORKDIR /work

COPY local/codeclimate-flake8 local/reporter.py /usr/local/bin/
COPY local/engine.json ./engine.json

RUN apk add --no-cache \
  python3~=3 \
  py3-pip~=20 \
  && apk add --no-cache --virtual build-deps \
  jq~=1 \
  && pip3 install \
  flake8 \
  && adduser -u 9000 -D app \
  && VERSION="$(flake8 --version | sed 's/ .*$//' | head -n 1)" \
  && jq --arg version "$VERSION" '.version = $version' > /engine.json < ./engine.json \
  && rm ./engine.json \
  && apk del build-deps

USER app

VOLUME /code
WORKDIR /code

CMD ["codeclimate-flake8"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="A Flake8 slim container and a CodeClimate engine container for GitLab CI"
LABEL org.opencontainers.image.documentation="https://github.com/ProfessorManhattan/codeclimate-flake8/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://gitlab.com/megabyte-labs/dockerfile/codeclimate/flake8.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="codeclimate"

FROM codeclimate AS flake8

WORKDIR /work

USER root

RUN rm /engine.json /usr/local/bin/codeclimate-flake8 /usr/local/bin/reporter.py

ENTRYPOINT ["flake8"]
CMD ["--version"]

LABEL space.megabyte.type="linter"
