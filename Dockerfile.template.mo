# 自動生成されました
# 基本直接編集しないでください。 Dockerfile.template.mo を使ってください
FROM debian:{{BASE_TAG}} as base
RUN echo 'deb http://archive.debian.org/debian {{OS_DISTRIBUTION}} main' > /etc/apt/sources.list \
  && echo 'deb http://archive.debian.org/debian-security {{OS_DISTRIBUTION}}/updates main' >> /etc/apt/sources.list \
  && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/check-valid-until.conf \
  && apt-get update

FROM base as completed
RUN apt-get update \
  && apt-get install --assume-yes --no-install-recommends \
    curl \
    ca-certificates \
    make \
    build-essential \
    patch \
    ruby-dev \
    zlib1g-dev \
    libffi-dev \
    liblzma-dev \
    libgmp-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
  && apt-get clean

RUN cd /tmp \
  && curl --output ruby.tar.gz {{URL}} \
  && ( echo '{{SHA256}}  ruby.tar.gz' | sha256sum --check ) \
  && mkdir ruby \
  && tar --ungzip --extract --file ./ruby.tar.gz --directory ruby/ --strip-components 1 \
  && cd /tmp/ruby \
  && ./configure --disable-install-doc \
  && make install \
  && rm -rf /tmp/ruby* \
  && echo "gem: --no-document\ngem: --no-ri --no-rdoc" > /root/.gemrc
