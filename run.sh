#!/bin/sh

test ! -d "/var/svn/template" && mkdir -p /var/svn/template/trunk && mkdir /var/svn/template/tags && mkdir /var/svn/template/branches

[[ -n "$SVN_REPO" ]] || SVN_REPO="testrepo"

echo "Creating the repository: $SVN_REPO into /var/svn/"
test ! -d "/var/svn/$SVN_REPO" && svnadmin create /var/svn/$SVN_REPO && chgrp -R apache /var/svn/$SVN_REPO && chmod -R 775 /var/svn/$SVN_REPO

if [ -n "$DAV_SVN_USER" ] && [ -n "$DAV_SVN_PASS" ]; then
htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd $DAV_SVN_USER $DAV_SVN_PASS
else
htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd davsvn davsvn
echo "Warning: DAV_SVN_USER / DAV_SVN_PASS variables not defined, starting with default account"
fi

httpd -D FOREGROUND
