#!/bin/bash
clear
echo 'Welcome to Simple Rainloop Webmail Installer'
echo '   '
echo 'Where Rainloop webmail directory will be installed?'
echo 'example: "/var/www/rainloop", or etc'
echo 'write same as example(without quotes), if you dont want to change in another directory'
read -p 'Directory: ' var
mkdir $var
cd $var
echo 'Installing...'
apt -y install unzip
wget https://www.rainloop.net/repository/webmail/rainloop-community-latest.zip
unzip rainloop-community-latest.zip -d $var
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
chown -R www-data:www-data .
rm rainloop-community-latest.zip
echo 'Configuring site'
cd /etc/apache2/sites-available
echo 'Insert your mail domain site'
echo 'example: mail.sekolah.sch.id'
read -p 'Mailsite: ' name
touch mailserver.conf
echo -e '<VirtualHost *:80>\nServerName' $name '\nServerAdmin webmaster@localhost\nDocumentRoot' $var '\nErrorLog ${APACHE_LOG_DIR}/error.log\nCustomLog ${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>' > mailserver.conf
a2ensite mailserver.conf
service apache2 restart
echo 'Installation Complete'
echo 'Access your admin site by type "mailsite.com/?admin", login as admin to configure imap and smtp connection'
echo 'Default user: admin, Default Password: 12345'
echo 'Bye ^_^'
echo '-made with <3'
read -p "Press enter to continue"
