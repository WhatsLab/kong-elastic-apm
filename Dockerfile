FROM golang:1.17 as build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 go build -o /kong-elastic-apm

FROM kong

COPY --from=build /kong-elastic-apm /usr/local/bin/