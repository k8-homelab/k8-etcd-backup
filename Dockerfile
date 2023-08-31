FROM alpine
RUN apk update && apk upgrade
RUN apk add curl

ENV ETCD_VER=v3.4.27
ENV URL=https://storage.googleapis.com/etcd

# INSTALL ETCD
RUN mkdir - /tmp/etcd /backup
RUN curl -L ${URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
RUN tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd --strip-components=1
RUN mv /tmp/etcd/etcdctl /usr/bin

# CLEAN UP
RUN rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
RUN rm -Rf /tmp/etcd

# PERMISSIONS
COPY --chown=1000 ./app /app
RUN chown 1000 /backup
WORKDIR /app

RUN echo "user:x:1000:1000:Unprivileged User:/home/user:/bin/bash" >> /etc/passwd
USER 1000

ENTRYPOINT ["/app/backup.sh"]