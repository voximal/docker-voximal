# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.

#Version ubuntu 18.04
FROM phusion/baseimage:0.11

#Voxibot URL
ARG VOXISTATURL=http://dl.voximal.net/nightly/voximal-stack/ubuntu18.04/x86-64/latest.run

#Set default mark
ARG MARKVAR=Docker-phusion-0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Get latest Stack
RUN curl -s -o /tmp/installer.run ${VOXISTATURL}

#Upgrade 
RUN apt-get update && apt-get upgrade -y

#important -- for .run args
#-d debug, -u not create uid.txt
RUN /bin/sh /tmp/installer.run -- -u -r

#Enable uid for next reboot
RUN touch /var/lib/voximal/uid.txt && chown asterisk: /var/lib/voximal/uid.txt

#Mark build, add at the end
RUN if test -f /var/lib/voximal/mark.txt ; then \
       echo -n "; "${MARKVAR}-$(date -I) >> /var/lib/voximal/mark.txt; \
    fi

#Remove errorlog from cron
RUN sed -i -e"s_cron -f_cron -f -L 0_" /etc/service/cron/run 

#Big cleanup
RUN apt-get clean;\
    rm -rf  /tmp/installer.run /voxibot* /etc/mysql/conf.d/mysqld_safe_syslog.cnf /var/lib/apt/lists/* /tmp/* /var/tmp/*
