FROM golang

ADD . /go/src/github.com/apolikamixitos/ethexporter
RUN cd /go/src/github.com/apolikamixitos/ethexporter && go get
RUN go install github.com/apolikamixitos/ethexporter

ENV GETH https://mainnet.infura.io
ENV PORT 9015

RUN mkdir /app
WORKDIR /app
ADD addresses.txt /app

EXPOSE 9015

ENTRYPOINT /go/bin/ethexporter
