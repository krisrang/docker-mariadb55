MariaDB 5.5 image
===

Run command

    docker run -d -name mariadb -p 3306:3306 -v /data/mysql:/data/main pebbles/mariadb
    
Logins
* User: root
* Password: docker

Persistent storage
---
This image uses persistent storage that located at /data/mysql in the image