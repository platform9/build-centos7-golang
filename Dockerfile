FROM mirror.gcr.io/golangci/golangci-lint:v1.62-alpine AS lint

FROM mirror.gcr.io/library/rockylinux:9
ARG GOLANG_VERSION
ARG TARGETARCH
RUN dnf -y --allowerasing install \
        curl \
        epel-release \
        git \
	wget \
        make
RUN dnf --enablerepo=devel -y install libvirt-devel
RUN wget -O /tmp/go.tgz https://go.dev/dl/go${GOLANG_VERSION}.linux-${TARGETARCH}.tar.gz \
	&& rm -rf /usr/local/go \
	&& tar -C /usr/local -xzf /tmp/go.tgz \
	&& ln -s /usr/local/go/bin/go /usr/bin/go \
	&& rm -f /tmp/go.tgz
COPY --from=lint /usr/bin/golangci-lint /usr/bin/
RUN dnf clean all
