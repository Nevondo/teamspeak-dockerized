# teamspeak-dockerized

TeamSpeak im Docker

## docker-compose.yml
```
version: '3.1'
services:
  teamspeak:
    image: docker.nevondo.com/nevondo/teamspeak-dockerized:3.13.7
    restart: always
    ports:
      - 9987:9987/udp
      - 10011:10011
      - 30033:30033
    environment:
      TS3SERVER_DB_PLUGIN: ts3db_mariadb
      TS3SERVER_DB_SQLCREATEPATH: create_mariadb
      TS3SERVER_DB_HOST: db
      TS3SERVER_DB_USER: root
      TS3SERVER_DB_PASSWORD: example
      TS3SERVER_DB_NAME: teamspeak
      TS3SERVER_DB_WAITUNTILREADY: 30
      TS3SERVER_LICENSE: accept
  db:
    image: mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: teamspeak

```
## docker-compose.yml
```
version: '2.3'
services:


##########################################################################
#
#    TeamSpeaks 
#

    teamspeak3-nevondo:
      image: docker.nevondo.com/nevondo/docker/teamspeak-dockerized:3.13.7
      environment:
        - TS3SERVER_LICENSE=accept
        - FILETRANSFER_PORT=30033
      volumes:
        - teamspeak3-nevondo:/var/ts3server/
      restart: unless-stopped
      ports:
        - 9987:9987/udp
        - 30033:30033
        - 10011:10011
          
#
#
##########################################################################

volumes:
  teamspeak3-nevondo:
```
