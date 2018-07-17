FROM ubuntu:16.04

MAINTAINER i3thuan5

ENV CPU_CORE 4

RUN \
  apt-get update -qq && \
  apt-get install -y \
    git bzip2 wget \
    g++ make python python3 \
    zlib1g-dev automake autoconf libtool subversion \
    libatlas-base-dev


WORKDIR /usr/local/
RUN git clone https://github.com/sih4sing5hong5/kaldi.git && \
  cd /usr/local/kaldi/tools && \
  extras/check_dependencies.sh && \
  make -j $CPU_CORE && \
  \
  cd /usr/local/kaldi/src && \
  ./configure && make depend -j $CPU_CORE && make -j $CPU_CORE && \
  \
  rm -rf /usr/local/kaldi/.git && \
  find /usr/local/kaldi/tools -type f \( -not -name '*.so' -and -not -name '*.so*' \) -delete && \
  find /usr/local/kaldi/src -not -executable -type f -delete

