FROM debian:wheezy-slim as base
RUN echo 'deb http://archive.debian.org/debian wheezy main' > /etc/apt/sources.list \
  && echo 'deb http://archive.debian.org/debian-security wheezy/updates main' >> /etc/apt/sources.list \
  && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/check-valid-until.conf \
  && apt-get update

FROM base as completed
RUN apt-get update
RUN apt-get install --assume-yes --no-install-recommends libffi-dev
RUN apt-get install --assume-yes --no-install-recommends curl
RUN apt-get install --assume-yes --no-install-recommends make
RUN apt-get install --assume-yes --no-install-recommends ca-certificates
WORKDIR /tmp
RUN cd /tmp \
  && curl --remote-name https://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p551.tar.gz
RUN cd /tmp/ && tar --ungzip --extract --file ./ruby-1.9.3-p551.tar.gz
RUN apt-get install --assume-yes --no-install-recommends build-essential
RUN apt-get install --assume-yes --no-install-recommends patch ruby-dev zlib1g-dev liblzma-dev libgmp-dev
RUN apt-get install --assume-yes --no-install-recommends libxml2-dev libxslt1-dev
RUN apt-get install --assume-yes --no-install-recommends libyaml-dev
RUN cd ./ruby-1.9.3-p551 && ./configure --disable-install-doc
RUN cd ./ruby-1.9.3-p551 && make install
RUN echo "gem: --no-document\ngem: --no-ri --no-rdoc" > /root/.gemrc
RUN apt-get clean
RUN rm -rf /tmp/ruby-1.9.3-*
