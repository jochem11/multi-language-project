FROM debian:bookworm-slim

WORKDIR /app

COPY build/mail-service .

EXPOSE 8084

CMD ["./mail-service"]
