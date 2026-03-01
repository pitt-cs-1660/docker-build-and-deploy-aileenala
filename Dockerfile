# =============================================================================
# stage 1: builder
# =============================================================================
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod main.go ./
COPY templates/ templates/

RUN CGO_ENABLED=0 go build -o app .
# =============================================================================
# stage 2: runtime (final image)
# =============================================================================
FROM scratch

COPY --from=builder /app/app /app
COPY --from=builder /app/templates /templates

CMD ["/app"]