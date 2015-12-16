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
   urpmi --no-recommends --auto --excludedocs urpmi
RUN ["urpmi", "--no-recommends", "--no-md5sum", "--excludedocs", \
    "--auto", "sudo", "git" ]
RUN useradd user ;\
   echo 'cubswin:)' | passwd user --stdin ; \
   echo 'cubswin:)' | passwd root --stdin ; \
   echo 'gem: --no-rdoc --no-ri' > ~user/.gemrc ; \
   cd ~user ; \
   su user -c "mkdir git" ; cd git ; \
   su user -c "git clone https://github.com/joequant/scms.git" ; \
   su user -c "git clone https://github.com/joequant/mayan-edms.git"
RUN cd ~user/git/scms/NScrypt ; \
   ../docker/install-packages-mageia.sh ; \
   cp ../docker/00_scms.conf /etc/httpd/conf/sites.d ; \
   cp ../docker/gitweb.conf /etc/conf.d ; \
   su user -c  ../docker/install-mayan.sh ; \	
   su user -c "gem install bundler rails" ; \
   su user -c "bundle install" ; \
   su user -c "./install.sh" ; \
   su user -c "./bin/setup"
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
CMD "/home/user/git/scms/docker/run-image.sh"


