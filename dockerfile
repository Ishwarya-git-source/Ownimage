# Stage 1 - Build and test the Go app
FROM golang:1.24 AS builder

WORKDIR /app

COPY go.mod ./
COPY . ./

# ✅ Run tests in the build stage
RUN go test ./...

# ✅ Then build the application
RUN go build -o myapp

# Stage 2 - Create a small image for running the app
FROM debian:bookworm-slim

WORKDIR /app
COPY --from=builder /app/myapp .

EXPOSE 8080

CMD ["./myapp"]
