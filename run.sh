#!/bin/sh

[[ -n "$SVN_REPO" ]] &&
{
  test ! -d "/svn/$SVN_REPO" && svnadmin create /svn/$SVN_REPO && chgrp -R apache /svn/$SVN_REPO && chmod -R 775 /svn/$SVN_REPO
}

test ! -d "/svn/template" && mkdir -p /svn/template/trunk && mkdir /svn/template/tags && mkdir /svn/template/branches

[[ -n "$SVN_USER"   &&  -n "$SVN_PASS" ]] && htpasswd -bc /etc/apache2/conf.d/davsvn.htpasswd $SVN_USER $SVN_PASS

[[ -z "$SVN_HTML" ]] ||
{
  rm -f /var/www/localhost/htdocs/index.html
  cp /svn/$SVN_HTML/index.html /var/www/localhost/htdocs/index.html
}

httpd -D FOREGROUND
