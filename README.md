# Документация Nginx + RustDesk 

Эта инструкция описывает процесс установки и настройки двух сервисов на сервере.

## Шаг 1: Обновление и установка необходимых пакетов

Выполните следующие команды для обновления пакетов на сервере:

    sudo apt update -y
    sudo apt upgrade -y

## Шаг 2: Разрешение доступа через порт 22

    sudo ufw allow 22

## Шаг 3: Установка и настройка сервиса Nginx

Создайте директорию и перейдите в нее:

    cd
    mkdir nginx
    cd nginx

Создайте файл `docker-compose.yml` и отредактируйте его:

    sudo nano docker-compose.yml

В файле `docker-compose.yml` вставьте следующий код:

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

Выход из редактора:

Нажмите Ctrl + X, затем Y и Enter.

Запустите контейнер Nginx:

    docker-compose up -d

## Шаг 4: Установка и настройка сервиса RustDesk

Создайте директорию и перейдите в нее:

    cd
    mkdir rustdesk
    cd rustdesk

Создайте файл `docker-compose.yml` и отредактируйте его:

    sudo nano docker-compose.yml

В файле `docker-compose.yml` вставьте следующий код:

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


> Можно добавить сколько угодно серверов по аналогии с этими


Выход из редактора:

Нажмите Ctrl + X, затем Y и Enter.

## Шаг 5: Подключение к сервису Nginx

Откройте браузер и введите в адресной строке внешний IP сервера с портом `:81`, например: `109.106.101.1:81`

Стандартные данные для входа:

    Email:    admin@example.com
    Password: changeme

Рекомендуется сразу изменить учетные данные после входа.

После входа в систему:

1. Перейдите на вкладку "Hosts"
2. Нажмите "Add Proxy Host"
3. В поле "Forward Hostname / IP" введите внешний IP сервера
4. В поле "Domain Names" введите один из доменов
5. В поле "Forward Port" введите порт, соответствующий домену из предыдущего пункта.

## Готово! Теперь осталось выписать ключи с необходимых серверов RustDesk


Откроем котейнер hbbs 

`sudo docker exec -it hbbs1 /bin/bash`

Выведем на экран ключ от первого сервера

`cat id_ed25519.pub`

Ключ должен быть в таком формат:

    j2P5Ky20DHuiqKp78SbiePiDorv0CsuKaW+pyHPJDo8=
