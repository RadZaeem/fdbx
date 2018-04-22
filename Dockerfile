# FROM ubuntu:16.04
# ENV container docker
# # Don't start any optional services except for the few we need.
# RUN find /etc/systemd/system \
#          /lib/systemd/system \
#          -path '*.wants/*' \
#          -not -name '*journald*' \
#          -not -name '*systemd-tmpfiles*' \
#          -not -name '*systemd-user-sessions*' \
#          -exec rm \{} \;
# RUN systemctl set-default multi-user.target
# CMD ["/sbin/init"]
FROM debian:buster
ENV container docker

### install systemd
RUN apt update && apt -y upgrade
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections
RUN apt -y install systemd resolvconf
RUN systemctl set-default multi-user.target
RUN ln -s /lib/systemd/systemd /sbin/init
CMD ["/sbin/init"]

RUN apt-get update
#; apt-get -y upgrade
RUN apt-get -y plinth
# RUN apt-get -y install rsyslog logrotate ssmtp logwatch cron vim

WORKDIR /host