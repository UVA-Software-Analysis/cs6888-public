FROM ubuntu:18.04

# Set the work directory 
WORKDIR /root

# Stop questions about geography
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC

# enable man pages
RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
        /etc/dpkg/dpkg.cfg.d/excludes

# Minimal setup
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    lsb-release \
    locales \
    gnupg2 \
    git \
    wget \
    vim \
    man \
    manpages-posix \
    python3 \
    python3-pip \
    tzdata \
    dnsutils \ 
    cmake \ 
    curl 

RUN dpkg-reconfigure locales


# CS6888 General 
RUN apt-get update && \
    apt-get install -y \
    afl \
    afl-cov \
    lcov \
    gcc \
    cppcheck 

# HW1

# https://github.com/AlexandreCarlton/afl-docker/blob/master/Dockerfile
# We set AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES and AFL_SKIP_CPUFREQ
# since we cannot respectively do without sudo privileges:
#   echo core >/proc/sys/kernel/core_pattern
# and
#   cd /sys/devices/system/cpu
#   echo performance | tee cpu*/cpufreq/scaling_governor
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 \
    AFL_SKIP_CPUFREQ=1 \
    CC=afl-gcc \
    CXX=afl-g++

### tcc
RUN git clone git://repo.or.cz/tinycc.git && \
    cd tinycc && \
    git checkout d348a9a51d32cece842b7885d27a411436d7887b && \
    ./configure --prefix=/root/tcc && \
    make CC=afl-gcc && \
    #make test && \
    make install && \
    cd .. && \
    rm -r tinycc

## tcc with coverage support
RUN git clone git://repo.or.cz/tinycc.git && \
    cd tinycc && \
    git checkout d348a9a51d32cece842b7885d27a411436d7887b && \
    ./configure --prefix=/root/tcc-cov --extra-cflags="-fprofile-arcs -ftest-coverage" --extra-ldflags="-coverage" && \
    make CC=afl-gcc && \
    #make test && \ 
    make install 

# HW4 
# infer (versions >=1 require newer glibc that isn't compatible with building tcc) 
RUN wget https://github.com/facebook/infer/releases/download/v0.17.0/infer-linux64-v0.17.0.tar.xz && \
    tar -xvf infer-linux64-v*.tar.xz && \
    rm infer-linux64-v*.tar.xz && \ 
    mv infer-* infer 

# cppcheck (build from source for `--bug-hunting` support, requires Z3)
RUN apt-get update && apt-get install -y libz3-dev && \
    git clone https://github.com/danmar/cppcheck.git && \
    cd cppcheck && \
    git checkout 2.7 && \
    mkdir build && \
    cd build && \
    cmake -DUSE_Z3=ON .. && \
    cmake --build . && \
    mkdir -p /usr/local/share/Cppcheck && \
    cp -r /root/cppcheck/build/bin/* /usr/local/share/Cppcheck
