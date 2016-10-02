FROM centos:6.8
MAINTAINER oppara

# RUN yum -y update

RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime \
&& echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock \
&& echo 'UTC="false"' >> /etc/sysconfig/clock  \
&& source /etc/sysconfig/clock


RUN yum -y groupinstall "Development Tools"  \
&& yum -y install sudo-devel openssh-server openssl-devel wget curl-devel expat-devel zlib-devel perl-ExtUtils-MakeMaker \
&& yum clean all


RUN useradd foo && passwd -f -u foo \
&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' &&  ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' \
&& mkdir -p /home/foo/.ssh; chown foo /home/foo/.ssh; chmod 700 /home/foo/.ssh

ADD ssh/foo.pub /home/foo/.ssh/authorized_keys

RUN chown foo /home/foo/.ssh/authorized_keys; chmod 600 /home/foo/.ssh/authorized_keys \
&& echo "foo ALL=(ALL) ALL" >> /etc/sudoers.d/foo


RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config \
&& /etc/init.d/sshd start && /etc/init.d/sshd stop

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

