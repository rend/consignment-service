FROM golang:alpine as builder
ENV GO111MODULE=on
RUN apk --no-cache add git
WORKDIR /app/consignment-service
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o consignment-service

FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/consignment-service/consignment-service .
CMD ["./consignment-service"]