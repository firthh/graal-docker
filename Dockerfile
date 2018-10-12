FROM oraclelinux:7-slim

ENV GRAALVM_VERSION=1.0.0-rc7

RUN set -eux; \
  yum install -y \
    gzip \
    tar \
  ; \
  rm -rf /var/cache/yum
RUN curl -Ls "https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz" | \
  tar zx -C /usr/local/ && \
  mv /usr/local/graalvm-ce-${GRAALVM_VERSION}/jre /usr/local/jre && \
  rm -rf /usr/local/graalvm-ce-${GRAALVM_VERSION} && \
  rm -rf /usr/local/jre/languages && \
  rm -rf /usr/local/jre/lib/svm && \
  rm -rf /usr/local/jre/bin/polyglot

ENV PATH $PATH:/usr/local/jre/bin

RUN java -Xshare:dump

RUN java -version
