FROM jetbrains/datalore-agent:2023.2-py3.10

USER root

RUN apt-get update && apt-get install -y \
    autoconf \
    libyaml-dev \
    sox \
    && \
    \
    cd /tmp && \
    curl -L https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz | tar xzf - && \
    cd /tmp/ruby-3.2.2 && \
    autoconf && \
    gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" && \
    ./configure --build="$gnuArch" --disable-install-doc --enable-shared --disable-install-static-library && \
    make install $MAKE_OPTIONS_RUBY && \
    cd / && rm -rf /tmp/ruby-3.2.2 && \
    ldconfig -v && \
    \
    rm -rf /var/lib/apt/lists/* && apt-get clean

USER datalore
