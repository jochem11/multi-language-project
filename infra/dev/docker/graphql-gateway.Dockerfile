FROM alpine:3.18
RUN apk add --no-cache ca-certificates libc6-compat
WORKDIR /app
COPY build/graphql-gateway /app/build/graphql-gateway
RUN chmod +x /app/build/graphql-gateway
ENTRYPOINT ["/app/build/graphql-gateway"]