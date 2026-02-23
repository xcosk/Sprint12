FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod tidy

COPY . .

RUN go build -o parcel-app .

FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/parcel-app /app/parcel-app
COPY tracker.db /app/tracker.db

CMD ["/app/parcel-app"]
