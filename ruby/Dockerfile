FROM debian:jessie
MAINTAINER nathan@radialogica.com

ENV DEBIAN_FRONTEND noninteractive
ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.3
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN buildDeps=' \
    bison \
    libbz2-dev \
    libgdbm-dev \
    libglib2.0-dev \
    libncurses-dev \
    libreadline-dev \
    libxml2-dev \
    libxslt-dev \
    ruby \
  ' \
  && apt-get update && apt-get upgrade -y \
  && apt-get install -y  --no-install-recommends $buildDeps \
    autoconf \
    gcc \
    make \
    bzip2 \
    ca-certificates \
    curl \
    libffi-dev \
    libgdbm3 \
    libssl-dev \
    libyaml-dev \
    procps \
    zlib1g-dev \
  && set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /usr/src/ruby \
  && curl -SL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" \
    | tar -xjC /usr/src/ruby --strip-components=1 \
  && cd /usr/src/ruby \
  && autoconf \
  && ./configure --disable-install-doc \
  && make -j"$(nproc)" \
  && make install \
  && apt-get purge -y --auto-remove $buildDeps \
  && echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc" \
  && gem update --system && gem pristine --all && gem install bundler \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin" \
  && rm -rf /usr/src/ruby /var/lib/apt/lists

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

CMD [ "irb" ]
