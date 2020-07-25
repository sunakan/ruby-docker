FROM debian:jessie-slim as base
RUN echo 'deb http://cdn-fastly.deb.debian.org/debian jessie main' > /etc/apt/sources.list.d/jessie.list \
  && echo 'deb http://security.debian.org/debian-security jessie/updates main' > /etc/apt/sources.list \
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
  && curl --output ruby.tar.gz https://ftp.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz \
  && ( echo 'a330e10d5cb5e53b3a0078326c5731888bb55e32c4abfeb27d9e7f8e5d000250  ruby.tar.gz' | sha256sum --check ) \
  && mkdir ruby \
  && tar --ungzip --extract --file ./ruby.tar.gz --directory ruby/ --strip-components 1 \
  && cd /tmp/ruby \
  && ./configure --disable-install-doc \
  && make install \
  && rm -rf /tmp/ruby* \
  && echo "gem: --no-document\ngem: --no-ri --no-rdoc" > /root/.gemrc