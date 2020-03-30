FROM ubuntu:eoan
ARG VIPS_VERSION=8.9.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

# basic build tools
RUN apt-get update && apt-get install -y build-essential autoconf automake libtool nasm unzip wget git pkg-config curl

RUN apt-get install -y libpng-dev libjpeg-turbo8-dev libpoppler-glib-dev && ldconfig

RUN cd /usr/local/src  && wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
    && tar xzf vips-${VIPS_VERSION}.tar.gz

RUN cd /usr/local/src/vips-${VIPS_VERSION} && ./configure && make && make install && ldconfig

# nodejs and Yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn
