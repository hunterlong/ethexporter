# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM golang:1.26.11-trixie AS build
ARG TARGETOS TARGETARCH
WORKDIR /src
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=bind,source=go.mod,target=go.mod \
    --mount=type=bind,source=go.sum,target=go.sum \
    go mod download
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=bind,target=. \
    CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -trimpath -ldflags="-s -w" -o /out/ethexporter .

FROM gcr.io/distroless/static-debian13:nonroot
COPY --from=build /out/ethexporter /usr/local/bin/ethexporter
WORKDIR /app
COPY addresses.txt .
ENV GETH=https://mainnet.infura.io PORT=9015
EXPOSE 9015
ENTRYPOINT ["/usr/local/bin/ethexporter"]
