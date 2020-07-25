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
  && curl --remote-name https://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p551.tar.gz \
  && tar --ungzip --extract --file ./ruby-1.9.3-p551.tar.gz \
  && cd /tmp/ruby-1.9.3-p551 \
  && ./configure --disable-install-doc \
  && make install \
  && rm -rf /tmp/ruby-* \
  && echo "gem: --no-document\ngem: --no-ri --no-rdoc" > /root/.gemrc

CMD ["irb"]
