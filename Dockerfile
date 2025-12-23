# ---------- Build stage ----------
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Copiar dependências primeiro (cache)
COPY go.mod go.sum ./
RUN go mod download

# Copiar o código
COPY . .

# Compilar binário
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o go-notes-app

# ---------- Runtime stage ----------
FROM alpine:latest

WORKDIR /app

# Copiar apenas o binário
COPY --from=builder /app/go-notes-app .

# Porta da aplicação
EXPOSE 8080

# Executar aplicação
CMD ["./go-notes-app"]
