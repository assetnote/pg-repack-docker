FROM postgres:13

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && \
    apt-get install -y \
    postgresql-server-dev-$PG_MAJOR \
    wget \
    openssh-server \
    libreadline8 \
    libreadline-dev \
    make \
    unzip \
    gcc \
    libssl-dev \
    zlib1g-dev \
    libreadline8 \
    libreadline-dev \
    libpq5 \
    libpq-dev

# COPY scripts .
# RUN chmod +x ./*.sh && bash ./install_pg_repack.sh
RUN wget -q -O pg_repack.zip "https://api.pgxn.org/dist/pg_repack/1.4.6/pg_repack-1.4.6.zip" \
    && unzip pg_repack.zip \
    && rm pg_repack.zip

RUN cd pg_repack-* \
    && make \
    && make install

RUN cd .. \
    && rm -rf pg_repack-*

RUN apt-get remove --auto-remove -y \
    make \
    unzip \
    gcc \
    libssl-dev \
    zlib1g-dev \
    libreadline8 \
    libreadline-dev \
    && rm -rf /var/lib/apt/lists/*
