# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.

#Version ubuntu 14.04
FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Upgrade 
RUN apt-get update && apt-get upgrade -y

#Get latest voxibot
RUN curl -s -o /tmp/installer.run http://dl.voximal.net/voxibot/ubuntu14.04/x86-64/latest.run

#important -- for .run args
#-d debug, -u not create uid.txt (must create , chow after )
RUN chmod +x /tmp/installer.run &&/bin/bash -c "/tmp/installer.run -- -u "

#Enable uid for next reboot
RUN touch /var/lib/voximal/uid.txt && chown asterisk: /var/lib/voximal/uid.txt

#Remove errorlog from cron
RUN sed -i -e"s_cron -f_cron -f -L 0_" /etc/service/cron/run 

#Big cleanup
RUN apt-get clean;\
    rm -rf  /tmp/installer.run /voxibot* /etc/mysql/conf.d/mysqld_safe_syslog.cnf /var/lib/apt/lists/* /tmp/* /var/tmp/*
