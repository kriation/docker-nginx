ARG NGINX_VERSION=stable

FROM kriation/centos7 as nginx-stable
RUN echo -e '[nginx-stable]\n\
name=nginx stable repo\n\
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://nginx.org/keys/nginx_signing.key\n\
module_hotfixes=true' >> /etc/yum.repos.d/nginx.repo

FROM kriation/centos7 as nginx-mainline
RUN echo -e '[nginx-mainline]\n\
name=nginx mainline repo\n\
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://nginx.org/keys/nginx_signing.key\n\
module_hotfixes=true' >> /etc/yum.repos.d/nginx.repo

FROM nginx-${NGINX_VERSION} as publish
ARG BUILD_DATE
ARG NGINX_VERSION
LABEL maintainer="armen@kriation.com" \
      org.label-schema.schema-version="1.0" \
			org.label-schema.build-date="$BUILD_DATE" \
			org.label-schema.license="GPLv2" \
			org.label-schema.name="NGINX on CentOS v7" \
			org.label-schema.version="nginx-$NGINX_VERSION" \
			org.label-schema.vendor="armen@kriation.com" \
			org.opencontainers.image.created="$BUILD_DATE" \
			org.opencontainers.image.licenses="GPL-2.0-only" \
			org.opencontainers.image.title="NGINX on CentOS v7" \
			org.opencontainers.image.version="nginx-$NGINX_VERSION" \
			org.opencontainers.image.vendor="armen@kriation.com"

# Install nginx and dependencies
RUN yum -y install nginx && yum -y clean packages

# Adjust ownership of specific directories
RUN find / -type d -iname nginx -execdir chown -R nginx:nginx {} \;

ENTRYPOINT ["/sbin/nginx", "-g", "daemon off; error_log /dev/stdout info;"]
