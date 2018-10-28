FROM alpine:3.7 as downloader
ENV VERSION=0.2.0
WORKDIR /tmp
RUN apk add --no-cache gzip tar curl ca-certificates && \
    curl -L --output do_sd.tar.gz https://github.com/totvslabs/prometheus-digitalocean-sd/releases/download/v${VERSION}/prometheus-digitalocean-sd_${VERSION}_linux_amd64.tar.gz && \
    tar xzvf do_sd.tar.gz

FROM scratch
COPY --from=downloader /tmp/prometheus-digitalocean-sd /
COPY --from=downloader /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
USER 65534
ENTRYPOINT ["/prometheus-digitalocean-sd"]
