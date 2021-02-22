FROM registry.suse.com/suse/sle15:15.2.8.2.844

COPY *.repo /etc/zypp/repos.d/

ENV ADDITIONAL_MODULES sle-module-web-scripting

RUN zypper refs && zypper --gpg-auto-import-keys refresh
RUN zypper -n in apache2 php7 apache2-mod_php7 subversion-server subversion-tools enscript tar gzip sed diffutils

COPY etc/ /etc/apache2/
COPY htdocs/ /srv/www/htdocs/

EXPOSE 80 

ENTRYPOINT ["/usr/sbin/httpd"]

CMD ["-D", "FOREGROUND"]
