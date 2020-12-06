FROM debian:9

COPY . .

RUN apt-get update && \
    apt-get install -y build-essential git wget pkg-config lxc-dev libzmq3-dev \
                       libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev \
                       liblz4-dev graphviz && \
    apt-get clean

RUN ./build/blockbook -sync -blockchaincfg=build/blockchaincfg.json -internal=:9030 -public=:9130