# Важно! К каждому контейнеру RustDesk необходимо прописывать отдельный порт, который не конфликтует с другими. Удобнее всего будет изменять 3 и 4 цифру в соответствии с сервером.


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