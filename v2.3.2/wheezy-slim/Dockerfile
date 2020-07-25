FROM debian:wheezy-slim as base
RUN echo 'deb http://archive.debian.org/debian wheezy main' > /etc/apt/sources.list \
  && echo 'deb http://archive.debian.org/debian-security wheezy/updates main' >> /etc/apt/sources.list \
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
  && curl --output ruby.tar.gz https://ftp.ruby-lang.org/pub/ruby/2.3/ruby-2.3.2.tar.gz \
  && ( echo '8d7f6ca0f16d77e3d242b24da38985b7539f58dc0da177ec633a83d0c8f5b197  ruby.tar.gz' | sha256sum --check ) \
  && mkdir ruby \
  && tar --ungzip --extract --file ./ruby.tar.gz --directory ruby/ --strip-components 1 \
  && cd /tmp/ruby \
  && ./configure --disable-install-doc \
  && make install \
  && rm -rf /tmp/ruby* \
  && echo "gem: --no-document\ngem: --no-ri --no-rdoc" > /root/.gemrc
