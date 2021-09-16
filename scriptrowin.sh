#!/bin/bash
function menu(){
clear
echo "Welkom bij de installatie. Selecteer een onderdeel dat u wilt installeren."
echo " "
PS3='Maak uw keuze: '
options=("Installeer Nextcloud" "Installeer Apache" "Installeer Nginx" "Installeer PHP" "Firewall aanpassen" "Installeer Certificaat" "Installeer Fail2ban" "Installeer extra benodigdheden" "Verlaat Script")
select opt in "${options[@]}"
do
	case $opt in
    "Verlaat Script")
            exit
            ;;
            
        "Installeer Nextcloud")
            echo "Wilt u Nextcloud installeren (y/n)"
                read answer0
            
            if [ "$answer0" != "${answer0#[Yy]}" ] ;then
                sudo wget https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
                     sudo unzip nextcloud-21.0.2.zip -d /var/www/nextcloud/
                     clear
                     echo "Nextcloud is succesvol geïnstalleerd."
                read einde
             else 
                            echo "Nextcloud is niet geïnstalleerd."
                                read einde
								clear
                                menu
                                    end
									fi
			;;
                                        
         "Installeer Fail2ban")
            sudo apt-get install fail2ban
            sudo cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
            sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
            sudo systemctl enable fail2ban
            sudo systemctl start fail2ban
            ;;
            "Firewall aanpassen")
                    clear
                    echo "Wilt u de firewall aanpassen? (y/n)"
                    read answer5
                        if [ "$answer5" != "${answer5#[Yy]}" ] ;then
                        sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
                        sudo iptables -I INPUT -p tcp --dport 443 -j ACCEPT
                            clear
                            echo " Firewall is aangepast (Druk op ENTER)"
                            read einde
							clear
                            menu
                 else if [ "$answer5" != "${answer5#[Nn]}" ] ;then
							clear
							echo "Firewall is niet geïnstalleerd."
							read einde
							clear
                   			menu
                    else
                        clear
                        menu    
                    
                    fi
					fi
            ;;
            "Installeer Certificaat")
                sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.key -out /etc/ssl/certs/apache-           selfsigned.crt
                sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
                clear
                echo "Certificaat is succesvol geïnstalleerd (Druk op ENTER)"
                read einde
				clear
                menu
                
            ;;
            "Installeer Nginx")
            echo "Wilt u Nginx installeren? (y/n)"
                    read answer1
            if [ "$answer1" != "${answer1#[Yy]}" ] ;then
                        sudo apt install mariadb-server
                        sudo mysql_secure_installation
                        sudo mysql_secure_installation
                        sudo apt install nginx -y
                        sudo systemctl start nginx
                        sudo systemctl enable nginx
                     clear
                     echo "Nginx is succesvol geïnstalleerd."
					 read einde
					 clear
					 menu
					 
            elif [ "$answer1" != "${answer1#[Nn]}" ] ;then
						echo "Nginx is niet geïnstalleerd."
                read einde
				clear
                menu
                        else
                        clear
                            echo "U heeft de verkeerde toetscombinatie ingedrukt (Druk op ENTER om door te gaan...)"
                                read einde
								clear
                                    menu
            fi
            ;;
            "Installeer Apache")
            echo "Wilt u apache installeren? (y/n)"
                    read answer1
            if [ "$answer1" != "${answer1#[Yy]}" ] ;then
                        sudo apt install apache2
                        sudo nano /etc/apache2/sites-available/nextcloud.conf
                        sudo a2ensite nextcloud.conf
                        sudo a2enmod rewrite headers env dir mime setenvif ssl
                        sudo chmod 775 -R /var/www/nextcloud/
                        sudo chown www-data:www-data /var/www/nextcloud/ -R
                        sudo systemctl restart apache2.service
                     clear
                     echo "Apache is succesvol geïnstalleerd."
					 read einde
					 clear
					 menu
					 
            elif [ "$answer1" != "${answer1#[Nn]}" ] ;then
					echo "Apache is niet geïnstalleerd."
                read einde
				clear
                menu
                        else
                        clear
                            echo "U heeft de verkeerde toetscombinatie ingedrukt (Druk op ENTER om door te gaan...."
                                read einde
								clear
                                    menu
								fi
            ;;
                              
                              
          "Installeer extra benodigdheden")
		  clear
		  echo "Wilt u mariadb-server installeren? (y/n)" 
          read answer3
          if [ "$answer3" != "${answer3#[Yy]}" ] ;then
                sudo apt install mariadb-server
                sudo mysql_secure_installation
			echo "U heeft mariadb-server succesvol geïnstalleerd"
        read einde
		clear
		menu
		
		elif [ "$answer3" != "${answer3#[Nn]}" ] ;then
			echo "Mariadb-server is niet geïnstalleerd."
			read einde
            clear
            menu
        else
            clear
            echo "Er is iets mis gegaan, probeer het nog een keer (Druk op ENTER om door te gaan...)"
            read einde
			clear
			menu
        fi
        
            ;;
       "Installeer PHP")
            echo "Wilt u PHP installeren? (y/n)"
                   read answer2
	if [ "$answer2" != "${answer2#[Yy]}" ] ;then
                clear
                echo "Voor welke server installeert u php? (Apache/Nginx)"
				read answer4
        	if [ "$answer4" == "Apache"] ;then
                sudo apt install php
                sudo apt install apache2 libapache2-mod-php7.4 openssl php-imagick php7.4- common    	php7.4-    curl php7.4-gd php7.4-imap php7.4-intl php7.4-json     php7.4-ldap php7.4-  	mbstring php7.4-  mysql php7.4-pgsql php-ssh2 php7.4- sqlite3 php7.4-xml php7.4-zip
                sudo nano /etc/php/7.4/cli/php.ini
                clear
                    echo "Succesvol geïnstalleerd (Druk op ENTER)"
                    read einde
					clear
                    menu
                    
				
			else if [ "$answer4" == "Nginx"] ;then
		clear
                sudo apt install imagemagick php-imagick php7.4-common php7.4-mysql php7.4-fpm php7.4-gd php7.4-json php7.4-curl  php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmpsudo apt install mariadb-server
                sudo nano /etc/php/7.4/cli/php.ini
                clear
                echo "Installatie geslaagd (Druk op ENTER)"
                    read einde
					clear
                    menu
	if [ "$answer2" != "${answer2#[Nn]}" ] ;then
                clear
                echo "PHP is niet geïnstalleerd"
				read einde
				clear
				menu
		else
		echo "U heeft de installatie beëindigd"
		read einde
		clear
		menu
fi
	fi
       fi
	     fi
            ;;
        *) echo "U heeft niets ingevoerd de installatie wordt beëindigd."
		read einde
		clear
		menu
		;;
    esac
done
}
menu