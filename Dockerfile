FROM       ubuntu:16.04
MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN chmod -R 777 /var/run/sshd
RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN chmod -R 777 /etc/ssh
RUN chmod 777 /usr/sbin/sshd
RUN chmod +s /usr/sbin/sshd

RUN groupadd -r appuser
RUN useradd -r -u 1001 -g appuser appuser
RUN chown appuser:appuser /usr/sbin/sshd
USER appuser
EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
