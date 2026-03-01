# =============================================================================
# stage 1: builder
# =============================================================================
FROM golang:1.23 AS builder

WORKDIR /app
COPY go.mod main.go ./templates

RUN CGO_ENABLED=0 go build -o app .
# =============================================================================
# stage 2: runtime (final image)
# =============================================================================
FROM scratch

WORKDIR /app

COPY --from=builder /app/app .
COPY --from=builder /app/templates ./templates

# document port
EXPOSE 8080

# run application
CMD ["/app/app"]