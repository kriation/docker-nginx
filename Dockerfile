FROM kriation/centos7
LABEL maintainer="armen@kriation.com"

ARG BUILD_DATE
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vendor=""
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.vendor=""

# Copy repo file
COPY nginx.repo /etc/yum.repos.d/

# Install nginx and dependencies (e.g. make, openssl)
RUN yum -y install nginx && yum -y clean packages

# Secure installation
RUN chown -R nginx:nginx /etc/nginx/ /usr/share/nginx/ \ 
	/var/cache/nginx/ /var/log/nginx/
