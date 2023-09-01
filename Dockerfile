FROM alpine
RUN apk update && apk upgrade
RUN apk add curl

ENV ETCD_VER=v3.4.27

# Install etcd
RUN mkdir -p /tmp/etcd && \
    curl -L https://storage.googleapis.com/etcd/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
    tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd --strip-components=1 && \
    mv /tmp/etcd/etcdctl /usr/bin && \
    rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
    rm -Rf /tmp/etcd

# Create the user
RUN echo "not-root:x:1000:1000:Not Root:/home/not-root:/bin/sh" >> /etc/passwd

# Copy app and set permissions
COPY --chown=1000 ./app /app
RUN chmod +x /app/backup.sh

# wysiwyg
WORKDIR /app
USER 1000
ENTRYPOINT ["/app/backup.sh"]