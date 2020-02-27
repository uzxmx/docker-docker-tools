ARG TAG
FROM docker:${TAG}

RUN apk add --no-cache \
  git \
  make
