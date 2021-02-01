FROM centos:centos7.6.1810
ARG GOLANG_VERSION
RUN yum -y install \
        curl \
        epel-release \
        https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm \
    && rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO \
    && curl -s https://mirror.go-repo.io/centos/go-repo.repo | tee /etc/yum.repos.d/go-repo.repo \
    && yum -y install \
        git \
        golang-${GOLANG_VERSION} \
        libvirt-devel \
        make \
    && yum clean all
