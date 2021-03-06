FROM debian:wheezy-slim as base
ENV LANG C.UTF-8
RUN echo 'deb http://archive.debian.org/debian wheezy main' > /etc/apt/sources.list \
  && echo 'deb http://archive.debian.org/debian-security wheezy/updates main' >> /etc/apt/sources.list \
  && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/check-valid-until.conf \
  && apt-get update

FROM base as completed
ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.3
ENV RUBY_DOWNLOAD_SHA256 0818beb7b10ce9a058cd21d85cfe1dcd233e98b7342d32e9a5d4bebe98347f01
RUN apt-get update \
  && apt-get install --assume-yes --no-install-recommends \
    curl \
    ca-certificates \
    build-essential \
    imagemagick \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libffi-dev \
    libglib2.0-dev \
    libjpeg-dev \
    liblzma-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install --assume-yes bison libgdbm-dev ruby \
  && mkdir --parents /usr/src/ruby/ \
  && cd /usr/src/ruby/ \
  && curl --output ruby.tar.gz https://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz \
  && ( echo "$RUBY_DOWNLOAD_SHA256  ruby.tar.gz" | sha256sum --check --strict ) \
  && tar --ungzip --extract --file ./ruby.tar.gz --directory /usr/src/ruby/ --strip-components 1 \
  && ./configure --disable-install-doc --enable-shared \
  && make install \
  && apt-get purge --assume-yes --auto-remove bison libgdbm-dev ruby \
  && cd / \
  && apt-get clean \
  && rm --recursive --force /var/lib/apt/lists/* \
  && rm --recursive --force /usr/src/ruby

ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $GEM_HOME/bin:$PATH
RUN mkdir --parents "$GEM_HOME" \
  && chmod 777 "$GEM_HOME" \
  && gem install bundler -v 1.17.3
