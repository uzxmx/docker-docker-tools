ARG TAG
FROM docker:${TAG}

RUN apk add --no-cache \
  git \
  make

ENV GLIBC_VER=2.31-r0

# aws-cli depends on glibc.
# Issue: https://github.com/aws/aws-cli/issues/4685
RUN tmpdir="$(mktemp -d)" \
  && cd ${tmpdir} \
  && apk --no-cache add \
       binutils \
       curl \
  && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
  && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
  && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
  && apk add --no-cache \
      glibc-${GLIBC_VER}.apk \
      glibc-bin-${GLIBC_VER}.apk \
  && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf \
      /usr/local/aws-cli/v2/*/dist/aws_completer \
      /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
      /usr/local/aws-cli/v2/*/dist/awscli/examples \
  && apk --no-cache del \
      binutils \
      curl \
  && rm -rf /var/cache/apk/* \
  && rm -rf ${tmpdir}
