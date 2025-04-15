FROM golangci/golangci-lint:v1.64-alpine

FROM rockylinux:9
ARG GOLANG_VERSION
RUN dnf -y --allowerasing install \
        curl \
        epel-release \
        git \
	wget \
        make
RUN dnf --enablerepo=devel -y install libvirt-devel
RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && ln -s /usr/local/go/bin/go /usr/bin/go
COPY --from=0 /usr/bin/golangci-lint /usr/bin/
RUN dnf clean all
