FROM kriation/centos7

MAINTAINER Armen Kaleshian <armen@kriation.com>

# Copy repo file
COPY nginx.repo /etc/yum.repos.d/

# Install nginx and dependencies (e.g. make, openssl)
RUN yum -y install nginx && yum -y clean all

# Secure installation
RUN chown -R nginx:nginx /etc/nginx/ /usr/share/nginx/ \ 
	/var/cache/nginx/ /var/log/nginx/
