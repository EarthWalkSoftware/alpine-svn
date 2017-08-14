FROM alpine
MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

VOLUME /svn
ENV SVN_ROOT=/svn

RUN apk --no-cache add apache2 apache2-utils apache2-webdav mod_dav_svn subversion
RUN mkdir -p /run/apache2

COPY vh-davsvn.conf /etc/apache2/conf.d/
COPY davsvn.htpasswd /etc/apache2/conf.d/
COPY run.sh /

RUN chmod +x /run.sh

EXPOSE 80

CMD ["/run.sh"]
