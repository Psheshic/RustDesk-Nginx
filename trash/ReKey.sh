#!/bin/bash

# Имя компании
read -p "Введите имя компании: " name

hbbs=hbbs_$name

hbbr=hbbr_$name


echo
echo
echo Имя первого контейнера: $hbbs
echo

echo
echo
echo Имя второго контейнера: $hbbr
echo

# Удаляем файлконтейнере name

docker exec $hbbs cat id_ed25519.pub

oldkey=$(docker exec $hbbs cat id_ed25519.pub)


echo
echo
echo
echo
echo
echo
echo Старый ключ: $oldkey
echo




sudo docker exec $hbbs rm id_ed25519

sudo docker exec $hbbs rm id_ed25519.pub




sudo docker exec $hbbr rm id_ed25519

sudo docker exec $hbbr rm id_ed25519.pub



sudo docker restart $hbbs
sudo docker restart $hbbr


newkeypub=$(docker exec $hbbs cat id_ed25519.pub)

newkeyprv=$(docker exec $hbbs cat id_ed25519)


echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo
echo Новый ключ: $newkeypub
echo
echo
echo


# Копируем файл id_ed25519 из контейнера name в контейнер name2

sudo docker exec $hbbr echo "$newkeypub" > id_ed25519.pub

sudo docker exec $hbbr echo "$newkeyprv" > id_ed25519



echo
echo
echo Ключи обновлены!
echo