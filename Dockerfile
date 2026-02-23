FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY . .

RUN go mod tidy
RUN go build -o parcel-app .

FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/parcel-app /app/parcel-app
COPY tracker.db /app/tracker.db

CMD ["/app/parcel-app"]
