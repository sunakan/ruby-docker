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
  && curl --output ruby.tar.gz https://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz \
  && ( echo '0818beb7b10ce9a058cd21d85cfe1dcd233e98b7342d32e9a5d4bebe98347f01  ruby.tar.gz' | sha256sum --check ) \
  && mkdir ruby \
  && tar --ungzip --extract --file ./ruby.tar.gz --directory ruby/ --strip-components 1 \
  && cd /tmp/ruby \
  && ./configure --disable-install-doc \
  && make install \
  && rm -rf /tmp/ruby* \
  && echo "gem: --no-document\ngem: --no-ri --no-rdoc" > /root/.gemrc