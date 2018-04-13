FROM golang

ADD . /go/src/github.com/hunterlong/ethexporter
RUN go get /go/src/github.com/hunterlong/ethexporter
RUN go install github.com/hunterlong/ethexporter

ENV GETH https://mainnet.infura.io/D9oCkP6QUkCLH9Kb37tG
ENV PORT 9015

RUN mkdir /app
WORKDIR /app
ADD addresses.txt /app

ENTRYPOINT /go/bin/ethexporter