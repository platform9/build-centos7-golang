FROM centos:centos7.6.1810

RUN yum -y remove git* \
    && yum -y install epel-release \
    && yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm \
    && yum -y install git libvirt-devel make golang-1.15.2-1.el7 \
    && yum clean all
