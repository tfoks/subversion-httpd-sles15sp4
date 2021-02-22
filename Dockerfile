FROM registry.suse.com/suse/sle15:15.2.8.2.844

ADD *.repo /etc/zypp/repos.d/
ADD *.service /etc/zypp/services.d

#RUN zypper -n addrepo https://download.opensuse.org/repositories/devel:tools:scm:svn/SLE_15_SP2/devel:tools:scm:svn.repo

RUN zypper refs && zypper --gpg-auto-import-keys refresh
RUN zypper -n in apache2 php7 apache2-mod_php7 subversion-server

ADD etc/ /etc/apache2/

EXPOSE 80 

ENTRYPOINT ["/usr/sbin/httpd"]

CMD ["-C", "Include /etc/apache2/sysconfig.d/loadmodule.conf", "-C", "Include /etc/apache2/sysconfig.d/global.conf", "-D", "FOREGROUND"]
