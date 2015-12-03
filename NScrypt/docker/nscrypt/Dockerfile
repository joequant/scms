FROM mageia:cauldron
MAINTAINER Joseph C Wang <joequant@gmail.com>
#RUN ["urpmi", "--no-recommends", "--auto", "--auto-update"]
VOLUME [ "/sys/fs/cgroup", "/var/lib/machines" ]
RUN echo "ZONE=Asia/Hong_Kong" > /etc/sysconfig/clock

RUN urpmi.removemedia -a ;\
    urpmi.addmedia --distrib \
       --mirrorlist \
       'http://mirrors.mageia.org/api/mageia.cauldron.x86_64.list' ; \
    urpmi.addmedia \
       "Core backup" http://distro.ibiblio.org/mageia/distrib/cauldron/x86_64/media/core/release ; \
    urpmi.addmedia \
       "Core updates backup" http://distro.ibiblio.org/mageia/distrib/cauldron/x86_64/media/core/updates ; \
   urpmi --no-recommends --auto --excludedocs urpmi ; \
   urpmi --replacepkgs --excludedocs locales glibc ; \
   urpmi --auto-select --auto --no-recommends --no-md5sum --excludedocs ; \
   urpme --auto-orphans --auto 
RUN ["urpmi", "--no-recommends", "--no-md5sum", "--excludedocs", "--auto", "sudo", "git", "apache", "apache-mod_suexec", "apache-mod_proxy", "apache-mod_php", "apache-mod_authnz_external", "apache-mod_ssl"]
RUN useradd user ;\
   echo 'cubswin:)' | passwd user --stdin ; \
   echo 'cubswin:)' | passwd root --stdin ; \
   cd ~user ; mkdir git ; cd git ; \
   git clone https://github.com/joequant/scms.git
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/* \
rm -f /lib/systemd/system/*resolve1* \
rm -f /lib/systemd/system/*resolved* \
rm -f /lib/systemd/system/*udev* \
rm -f /lib/systemd/system/*journal* \
rm -f /lib/systemd/system/*networkd*


EXPOSE 80 443
CMD ["/usr/sbin/init"]
