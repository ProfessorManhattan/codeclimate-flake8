FROM python:alpine AS codeclimate-build

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="A slim Flake8 and a CodeClimate engine container for GitLab CI"
LABEL org.opencontainers.image.documentation="https://github.com/megabyte-labs/codeclimate-flake8/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://github.com/megabyte-labs/codeclimate-flake8.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="codeclimate"

FROM codeclimate-build AS codeclimate

WORKDIR /work

COPY local/codeclimate-flake8 /usr/local/bin/
COPY local/engine.json ./engine.json

RUN chmod +x /usr/local/bin/codeclimate-flake8 \
  && apk add --no-cache \
  bash~=5 \
  curl~=7 \
  jq~=1 \
  python3~=3 \
  py3-pip~=22 \
  && pip3 install \
  flake8==4.* \
  flake8-builtins==1.* \
  flake8-gl-codeclimate==0.* \
  flake8-pytest-style==1.* \
  flake8-simplify==0.* \
  wemake-python-styleguide==0.* \
  && adduser -u 9000 -D app \
  && VERSION="$(flake8 --version | sed 's/ .*$//' | head -n 1)" \
  && jq --arg version "$VERSION" '.version = $version' > /engine.json < ./engine.json \
  && rm ./engine.json

USER app

VOLUME /code
WORKDIR /code

CMD ["codeclimate-flake8"]

FROM codeclimate-build AS flake8

WORKDIR /work

USER root

RUN apk add --no-cache \
  python3~=3 \
  py3-pip~=22 \
  && pip3 install \
  flake8 \
  flake8-builtins \
  flake8-pytest-style \
  flake8-simplify \
  wemake-python-styleguide

ENTRYPOINT ["flake8"]
CMD ["--version"]

LABEL space.megabyte.type="linter"
