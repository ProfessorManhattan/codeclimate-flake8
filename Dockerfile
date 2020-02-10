FROM python:3.6.9-alpine

LABEL maintainer="Jorge Klemm <jorge@mercos.com>"

RUN apk add build-base

WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/

RUN pip install -r requirements.txt

RUN adduser -u 9000 -D app
COPY . /usr/src/app
RUN chown -R app:app .

USER app

VOLUME /code
WORKDIR /code

CMD [ "/usr/src/app/codeclimate-flake8" ]
