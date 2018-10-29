#!/bin/bash
echo ativar o novo VirtualHost sudo a2ensite app.conf
docker exec -it a2ensite app.conf
echo reiniciar o apache2 
#RUN service apache2 reload
docker exec -it service apache2 reload
echo install composer
#RUN composer install
docker exec -it composer install