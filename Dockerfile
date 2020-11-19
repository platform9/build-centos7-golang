FROM centos:centos7.6.1810

RUN yum -y remove git*

RUN yum -y install epel-release
RUN yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
RUN yum -y install git
RUN yum -y install libvirt-devel make

RUN yum -y install golang-1.15.2-1.el7
