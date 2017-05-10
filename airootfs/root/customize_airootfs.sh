#!/bin/bash

set -e -u

# sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(en_GB\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

chown root:root /
chown root:root -R /etc /root
passwd -l root  # remove comment for non-debug

useradd -m -s /bin/bash dapper	# !! must be /bin/bash not /usr/bin/bash
# useradd -m -G wheel -s /bin/bash dapper	# wheel is temporary to allow sudo during debug
# echo 'dapper:dapper'|chpasswd # temporary

mkdir -p /media/dapper-data

mkdir /opt/MyEtherWallet
unzip /home/dapper/mew-v3.7.0.zip -d /opt/MyEtherWallet

#sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

# systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target
systemctl enable ntpd privoxy ufw connman.service dnscrypt-proxy.service # spice-vdagent # mount-dapper-data
# systemctl disable ldconfig.service  # this doesn't seem to disable it. causes longer boot time. isn't needed for live boot usb. touch /etc/.updated /var/.updated does the trick though

ufw default deny
ufw enable

# loginctl enable-linger dapper
# systemctl --user enable mount-dapper-data

# connmanctl disable ethernet

# setfattr -n user.pax.flags -v "emr" /usr/bin/mist   # allows mist to work with grsecurity/pax
touch /etc/.updated /var/.updated                   # prevents ldconfig.service from running on boot (unnecessary time for live boot)
