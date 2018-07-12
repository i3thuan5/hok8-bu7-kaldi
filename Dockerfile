FROM ubuntu:latest

MAINTAINER sih4sing5hong5

ENV CPU_CORE 4

RUN \
  apt-get update -qq && \
  apt-get install -y \
    git bzip2 wget \
    g++ make python python3 \
    zlib1g-dev automake autoconf libtool subversion \
    libatlas-base-dev


WORKDIR /usr/local/
# Use the newest kaldi version
RUN git clone https://github.com/kaldi-asr/kaldi.git


WORKDIR /usr/local/kaldi/tools
RUN extras/check_dependencies.sh
RUN make -j $CPU_CORE && \
  find . -type f \( -not -name '*.so' -and -not -name '*.so*' \) -delete

WORKDIR /usr/local/kaldi/src
RUN ./configure && make depend -j $CPU_CORE && make -j $CPU_CORE
RUN find . -not -executable -type f -delete
