FROM scratch
ADD https://gitlab.itoodev.com/wrkgrp/wrkspc/-/blob/master/assets/alpine-minirootfs-3.13.5-x86_64.tar.gz /

ENV BUILD_DEPS \
    alpine-sdk \
    cabal \
    coreutils \
    ghc \
    libffi \
    musl-dev \
    zlib-dev

ENV PERSISTENT_DEPS \
    gmp \
    graphviz \
    openjdk11-jre \
    python \
    py2-pip \
    sed \
    ttf-droid \
    ttf-droid-nonlatin

ENV PLANTUML_VERSION 1.2019.8
ENV PLANTUML_DOWNLOAD_URL https://sourceforge.net/projects/plantuml/files/plantuml.$PLANTUML_VERSION.jar/download

ENV PANDOC_VERSION 2.7.3
ENV PANDOC_DOWNLOAD_URL https://hackage.haskell.org/package/pandoc-$PANDOC_VERSION/pandoc-$PANDOC_VERSION.tar.gz
ENV PANDOC_ROOT /usr/local/pandoc

ENV PATH $PATH:$PANDOC_ROOT/bin

RUN apk upgrade --update --no-cache && \
    apk add --virtual .build-deps $BUILD_DEPS && \
    apk add --virtual .persistent-deps $PERSISTENT_DEPS && \
    curl -fsSL "$PLANTUML_DOWNLOAD_URL" -o /usr/local/plantuml.jar && \
    chmod a+r /usr/local/plantuml.jar && \
    mkdir -p /pandoc-build \
             /var/docs && \
    cd /pandoc-build && \
    curl -fsSL "$PANDOC_DOWNLOAD_URL" | tar -xzf - && \
    cd pandoc-$PANDOC_VERSION && \
    cabal update && \
    cabal install --only-dependencies && \
    cabal configure --prefix=$PANDOC_ROOT && \
    cabal build && \
    cabal copy && \
    cd / && \
    rm -Rf /pandoc-build \
           $PANDOC_ROOT/lib \
           /root/.cabal \
           /root/.ghc && \
    set -x && \
    addgroup -g 82 -S pandoc && \
    adduser -u 82 -D -S -G pandoc pandoc && \
    apk del .build-deps

COPY plantuml /usr/local/bin/

USER pandoc

WORKDIR /var/docs
COPY *.md .

ENTRYPOINT [ "pandoc" ]
CMD [ "README.md", "--pdf-engine=xelatex", "-o", "Daniel Owen van Dommelen - resume.pdf" ]