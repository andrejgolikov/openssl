#!/bin/sh

# Создание самозаверяющего сертификата с помощью пользовательского корневого ЦС
# https://learn.microsoft.com/ru-ru/azure/application-gateway/self-signed-certificates

printf "1. Создание сертификата корневого ЦС\n"

read -p "Введите базовое имя файлов ключей сертификата корневого ЦС [ca.personal.localhost(.crt|.csr|.key|.srl)]:" caKeysFilesCanonicalName
caKeysFilesCanonicalName=${caKeysFilesCanonicalName:-"ca.personal.localhost"}

printf "\n  1.1. Создание корневого ключа: $caKeysFilesCanonicalName.key\n"
openssl ecparam -out $caKeysFilesCanonicalName.key -name prime256v1 -genkey

printf "\n  1.2. Создание корневого сертификата и его самозаверение\n"

printf "\n    1.2.1. Создание запроса на подпись сертификата (CSR): $caKeysFilesCanonicalName.csr\n"
openssl req -new -sha256 -key $caKeysFilesCanonicalName.key -out $caKeysFilesCanonicalName.csr

printf "\n    1.2.2. Создание корневого сертификата: $caKeysFilesCanonicalName.crt\n"
openssl x509 -req -sha256 -days 365 -in $caKeysFilesCanonicalName.csr -signkey $caKeysFilesCanonicalName.key -out $caKeysFilesCanonicalName.crt

printf "\n2. Создание сертификата сервера\n"

read -p "Введите базовое имя файлов ключей сервера [server.personal.localhost(.crt|.csr|.key)]:" serverKeysFilesCanonicalName
serverKeysFilesCanonicalName=${serverKeysFilesCanonicalName:-"server.personal.localhost"}

printf "\n  2.1. Создание ключа сертификата: $serverKeysFilesCanonicalName.key\n"
openssl ecparam -out $serverKeysFilesCanonicalName.key -name prime256v1 -genkey

printf "\n  2.2. Создание запроса на подпись сертификата (CSR): $serverKeysFilesCanonicalName.csr\n"
openssl req -new -sha256 -key $serverKeysFilesCanonicalName.key -out $serverKeysFilesCanonicalName.csr

printf "\n  2.3. Создание сертификата с использованием CSR и ключа, а также подписывание сертификата с помощью корневого ключа ЦС: $serverKeysFilesCanonicalName.crt\n"
openssl x509 -req -in $serverKeysFilesCanonicalName.csr -CA $caKeysFilesCanonicalName.crt -CAkey $caKeysFilesCanonicalName.key -CAcreateserial -out $serverKeysFilesCanonicalName.crt -days 365 -sha256

printf "\n  2.4. Проверка созданного сертификата: $serverKeysFilesCanonicalName.crt\n"
openssl x509 -in $serverKeysFilesCanonicalName.crt -text -noout

printf "\nСгенерированные ключи были сохранены в папке keys"
