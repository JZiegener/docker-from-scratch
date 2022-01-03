FROM golang:1.17 AS builder

WORKDIR /app/
ADD go.* /app/
RUN go mod download

ADD main.go /app/
ENV CGO_ENABLED=0
RUN go build -o /docker-from-scratch main.go

FROM scratch
COPY --from=builder /docker-from-scratch /docker-from-scratch
CMD ["/docker-from-scratch"]
