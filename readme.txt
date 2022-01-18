- requirements

Docker version 20.10.12
docker-compose version 1.25.0

- commands

#Make docker image
$ docker build -t wordpress1 .

#Get starting two containers with docker-compose (Apache Web Server with WordPress & MySQL)
$ docker-compose up

#Check your hostname. for example :

$ curl your_ip_address:80


