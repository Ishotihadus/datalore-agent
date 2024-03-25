FROM jetbrains/datalore-agent:2024.1-py3.10

USER root

RUN apt-get -y update && apt-get -y install \
    autoconf \
    libfontconfig-dev \
    libfreetype-dev \
    libglu1-mesa \
    libglu1-mesa-dev \
    libjpeg-dev \
    libltdl-dev \
    libomp-dev \
    libpng-dev \
    libxi-dev \
    libxmu-dev \
    libyaml-dev \
    sox \
    && \
    \
    cd /tmp && \
    curl -L https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.gz | tar xzf - && \
    cd /tmp/ruby-3.3.0 && \
    autoconf && \
    gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" && \
    ./configure --build="$gnuArch" --disable-install-doc --enable-shared --disable-install-static-library && \
    make install $MAKE_OPTIONS_RUBY && \
    cd / && rm -rf /tmp/ruby-3.3.0 && \
    \
    cd /tmp && \
    curl -L https://imagemagick.org/download/ImageMagick-7.1.1-29.tar.gz | tar xzf - && \
    cd /tmp/ImageMagick-7.1.1-29 && \
    ./configure --enable-shared --with-modules --disable-docs && \
    make install $MAKE_OPTIONS && \
    cd / && rm -rf /tmp/ImageMagick-7.1.1-29 && \
    \
    ldconfig -v && \
    \
    rm -rf /var/lib/apt/lists/* && apt-get -y clean

USER datalore
