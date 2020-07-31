FROM debian:jessie-slim as base
ENV LANG C.UTF-8
RUN echo 'deb http://cdn-fastly.deb.debian.org/debian jessie main' > /etc/apt/sources.list.d/jessie.list \
  && echo 'deb http://security.debian.org/debian-security jessie/updates main' > /etc/apt/sources.list \
  && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/check-valid-until.conf \
  && apt-get update

FROM base as completed
ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.1
ENV RUBY_DOWNLOAD_SHA256 c843df31ae88ed49f5393142b02b9a9f5a6557453805fd489a76fbafeae88941
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
  && curl --output ruby.tar.gz https://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz \
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
