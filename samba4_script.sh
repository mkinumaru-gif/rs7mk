#!/bin/bash
## Install Samba4 4.11.6
## On Debian
## Author: Marcio Inumaru
## Version: 0.5

### Tested on Debian

apt-get update ; apt-get upgrade
apt-get install wget
apt-get install build-essential libacl1-dev libattr1-dev
apt-get install libblkid-dev libgnutls28-dev libreadline-dev python-dev libpam0g-dev
apt-get install python-dnspython gdb pkg-config libpopt-dev libldap2-dev
apt-get install dnsutils libbsd-dev attr krb5-user docbook-xsl libcups2-dev acl
apt-get install acl attr autoconf bind9utils bison build-essential
apt-get install debhelper dnsutils docbook-xml docbook-xsl flex gdb libjansson-dev krb5-user
apt-get install libacl1-dev libaio-dev libarchive-dev libattr1-dev libblkid-dev libbsd-dev
apt-get install libcap-dev libcups2-dev libgnutls28-dev libgpgme-dev libjson-perl
apt-get install libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl
apt-get install libpopt-dev libreadline-dev nettle-dev perl perl-modules pkg-config
apt-get install python-all-dev python-crypto python-dbg python-dev python-dnspython
apt-get install python3-dnspython python-gpgme python3-gpgme python-markdown python3-markdown
apt-get install python3-dev xsltproc zlib1g-dev liblmdb-dev lmdb-utils


cd /usr/src
wget https://download.samba.org/pub/samba/stable/samba-4.11.6.tar.gz
tar -xzvf samba-4.11.6.tar.gz
cd samba-4.6.11
./configure
make
make install


echo [Unit]
Description=Samba4 AD Daemon
After=syslog.target network.target

[Service]
Type=forking
PIDFile=/usr/local/samba/var/run/samba.pid
LimitNOFILE=16384
ExecStart=/usr/local/samba/sbin/samba -D
ExecReload=/usr/bin/kill -HUP

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/samba4.service

### Add PATH
echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/local/samba/sbin:/usr/local/samba/bin">> /root/.bashrc
source /root/.bashrc

### Add start script on boot
systemctl daemon-reload
systemctl enable samba4.service
systemctl start samba4.service

### To use Samba4 acls, add the following mount options to your data filesystems user_xattr,acl.
### If you use xfs you can also add barrier=1 which ensures that tdb transactions are safe against unexpected power loss.
## errors=remount-ro

### Change fstab
cp /etc/fstab /etc/fstab_$$.bkp
sed -i 's|errors=remount-ro|errors=remount-ro,acl,user_xattr,barrier=1|' /etc/fstab
mount -o remount /
