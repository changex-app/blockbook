FROM gostartups/golang-rocksdb-zeromq

# This library is required for building v0.4.0
RUN apt-get install libzstd-dev

WORKDIR /home
# Build blockbook
COPY . /home/blockbook

WORKDIR /home/blockbook
RUN go mod download
RUN go mod tidy
RUN CGO_CFLAGS="-I/opt/rocksdb/include -O -D__BLST_PORTABLE__" go build

ENV BLOCKBOOK_PORT=9170

RUN ./contrib/scripts/build-blockchaincfg.sh kucoin && \
    rm -rf api docs configs contrib db fiat bchain common fourbyte server tests && \
    rm CONTRIBUTING.md Makefile blockbook-api.d.ts go.mod go.sum shell.nix COPYING README.md

COPY run.sh run.sh

EXPOSE 9170

ENTRYPOINT sh run.sh

# new blockbooks - kucoin, binances smart chain
# old blockbooks - ethereum , polygon , zcash , arbitrum , bitcoin gold , hydra , bitcoin