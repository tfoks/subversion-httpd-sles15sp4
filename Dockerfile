FROM registry.suse.com/suse/sle15:15.3.17.5.1

LABEL maintainer="thomas.foks@capgemini.com"

COPY *.repo /etc/zypp/repos.d/

ENV ADDITIONAL_MODULES sle-module-web-scripting

RUN zypper refs && zypper --gpg-auto-import-keys refresh
RUN zypper -n in apache2 php7 apache2-mod_php7 subversion-server subversion-tools enscript tar gzip sed diffutils

COPY apache2/ /etc/apache2/
COPY htdocs/ /srv/www/htdocs/

# add WebSVN to htdocs
COPY websvn-2.6.1.tar.gz /srv/www/htdocs/
RUN cd /srv/www/htdocs && tar xzf websvn-2.6.1.tar.gz && mv websvn-2.6.1 websvn && rm websvn-2.6.1.tar.gz
COPY config.php /etc/websvn/

RUN cd /srv/www/htdocs && chown -R wwwrun:www *

EXPOSE 80 
EXPOSE 443 

ENTRYPOINT ["/usr/sbin/httpd"]

CMD ["-D", "FOREGROUND"]
