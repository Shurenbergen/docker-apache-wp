
#Make docker image
$ docker build -t your_build_name .

#upd docker-compose file, write your build name in service

#check wp-config.php and yourdomain.conf
#rename yourdomain.conf

#Get starting two containers with docker-compose (Apache Web Server with WordPress & MySQL)
$ docker-compose up

#Check your hostname. for example :

$ curl 192.168.0.46:80



#Run docker container whith ports u need
$ docker run -it --restart=always -p your_localhost_ip:80:80 your_build_name