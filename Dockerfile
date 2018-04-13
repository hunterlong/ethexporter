FROM golang

ADD . /go/src/github.com/hunterlong/ethexporter
WORKDIR /go/src/github.com/hunterlong/ethexporter
RUN go get
RUN go install github.com/hunterlong/ethexporter

ENV GETH https://mainnet.infura.io/D9oCkP6QUkCLH9Kb37tG
ENV PORT 9015

ENTRYPOINT /go/bin/ethexporter