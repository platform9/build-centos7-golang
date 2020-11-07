FROM centos:centos7.6.1810

RUN yum -y install epel-release

RUN yum -y install libvirt-devel make

RUN yum -y install golang-1.15.2-1.el7
