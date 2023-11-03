sudo apt update -y

sudo apt upgrade -y

sudo ufw allow 22


cd 

mkdir nginx

cd nginx 

sudo nano docker-compose.yml

# В файле пишем: 

version: '3.8'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt

# Выходим из nano

docker-compose up -d




cd 

mkdir rustdesk

cd rustdesk

sudo nano docker-compose.yml



# В файле пишем:

version: '3'

networks:
  rustdesk-net:
    external: false

services:
  hbbs1:
    container_name: hbbs1
    ports:
      - 21115:21115
      - 21116:21116
      - 21116:21116/udp
      - 21118:21118
    image: rustdesk/rustdesk-server:latest
    command: hbbs -r server_1.example.com:21117
    volumes:
      - ./data:/root
    networks:
      - rustdesk-net
    depends_on:
      - hbbr1
    restart: unless-stopped

  hbbr1:
    container_name: hbbr1
    ports:
      - 21117:21117
      - 21119:21119
    image: rustdesk/rustdesk-server:latest
    command: hbbr
    volumes:
      - ./data:/root
    networks:
      - rustdesk-net
    restart: unless-stopped


  hbbs2:
    container_name: hbbs2
    ports:
      - 21125:21125
      - 21126:21126
      - 21126:21126/udp
      - 21128:21128
    image: rustdesk/rustdesk-server:latest
    command: hbbs -r server_2.example.com:21127
    volumes:
      - ./data:/root
    networks:
      - rustdesk-net
    depends_on:
      - hbbr2
    restart: unless-stopped

    hbbr2:
    container_name: hbbr2
    ports:
      - 21127:21127
      - 21129:21129
    image: rustdesk/rustdesk-server:latest
    command: hbbr
    volumes:
      - ./data:/root
    networks:
      - rustdesk-net
    restart: unless-stopped


# Выходим из nano

# Заходим на сервер по внешнему ip с портом 81. Например: 109.106.101.1:81
#
# Стандартные данные для входа:
#
# Email:    admin@example.com
# Password: changeme
# 
# Лучше сразу заменить данные для входа на другие
#
# Переходим во вкладку hosts
#
# Жмякаем Add Proxy Host
# В "Forward Hostname / IP" вводим внешний IP сервера
# В "Domain Names" вводим один из доменов 
# В "Forward Port" вводим порт соответствующий домену в предыдущем пункте
