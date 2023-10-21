FROM fedora:38
LABEL maintainer="Yanis Kernoua <yanis.kernoua@epitech.eu>"

# Update and install primary tools
RUN dnf -y upgrade && \
    dnf -y install dnf-plugins-core && \
    dnf -y --refresh install --setopt=tsflags=nodocs --setopt=deltarpm=false \
    clang.x86_64 \
    gcc-c++.x86_64 \
    gcc.x86_64 \
    gdb.x86_64 \
    glibc-devel.x86_64 \
    glibc-locale-source.x86_64 \
    glibc.x86_64 \
    make.x86_64 \
    cmake.x86_64 \
    valgrind.x86_64 \
    git \
    vim \
    ncurses-devel.x86_64 \
    elfutils-libelf-devel.x86_64 \
    tmux.x86_64 \
    tar.x86_64 \
    wget.x86_64 \
    which.x86_64 \
    python3-pip \
    xz && \
    dnf clean all -y

# Upgrade pip and install Python packages
RUN python3 -m pip install --upgrade pip -v && \
    python3 -m pip install \
    gcovr==6.0 \
    pycryptodome==3.18.0 \
    requests==2.31.0 \
    pyte==0.8.1 \
    numpy==1.25.2 && \
    localedef -i en_US -f UTF-8 en_US.UTF-8

# Install Criterion
RUN curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.2/criterion-2.4.2-linux-x86_64.tar.xz" -o /tmp/criterion.tar.xz && \
    tar xf /tmp/criterion.tar.xz -C /tmp && \
    cp -r /tmp/criterion-2.4.2/* /usr/local/ && \
    echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf && \
    ldconfig && \
    rm -rf /tmp/criterion-2.4.2 /tmp/criterion.tar.xz

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

WORKDIR /usr/app
