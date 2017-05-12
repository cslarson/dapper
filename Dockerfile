##
# NAME             : nlhomme/archiso-builder
# TO_BUILD         : docker build --rm -t nlhomme/archiso-builder:latest .
# TO_RUN           : docker run --rm -v /tmp:/tmp -t -i --privileged nlhomme/archiso-builder:latest
##

FROM finalduty/archlinux:latest
#FROM dock0/arch

#Install git and archiso
RUN pacman -S git archiso --noconfirm --needed

#RUN modprobe loop

#Copy the build script and allow him to be executed
COPY docker/buildscript.sh root/

#Place the terminal in the home folder
RUN ["chmod", "+x", "root/buildscript.sh"]

ENTRYPOINT ["./root/buildscript.sh"]
