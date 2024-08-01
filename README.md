# Создание самозаверяющего сертификата с помощью пользовательского корневого ЦС

Более подробную информацию можно получить [по ссылке](https://learn.microsoft.com/ru-ru/azure/application-gateway/self-signed-certificates) на ресурсе `learn.microsoft.com`.

## Генерация ключей

Для генерации ключей достаточно запустить в командной строке скрипт [Generate-Certificate.bat](./bin/Generate-Certificate.bat):

```cmd
E:\work\ga\localhost\docker\openssl>.\bin\Generate-Certificate.bat
1. Создание сертификата корневого ЦС
Введите базовое имя файлов ключей сертификата корневого ЦС [ca.personal.localhost(.crt|.csr|.key|.srl)]:

  1.1. Создание корневого ключа: ca.personal.localhost.key

  1.2. Создание корневого сертификата и его самозаверение

    1.2.1. Создание запроса на подпись сертификата (CSR): ca.personal.localhost.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [RU]:
State or Province Name (full name) [Tula region]:
Locality Name (eg, city) [Tula]:
Organization Name (eg, company) [Personal]:
Organizational Unit Name (eg, section) [Directorate]:
Common Name (e.g. server FQDN or YOUR name) [ca.personal.localhost]:
Email Address [info@ca.personal.localhost]:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:

    1.2.2. Создание корневого сертификата: ca.personal.localhost.crt
Certificate request self-signature ok
subject=C=RU, ST=Tula region, L=Tula, O=Personal, OU=Directorate, CN=ca.personal.localhost, emailAddress=info@ca.personal.localhost

2. Создание сертификата сервера
Введите базовое имя файлов ключей сервера [server.personal.localhost(.crt|.csr|.key)]:

  2.1. Создание ключа сертификата: server.personal.localhost.key

  2.2. Создание запроса на подпись сертификата (CSR): server.personal.localhost.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [RU]:
State or Province Name (full name) [Tula region]:
Locality Name (eg, city) [Tula]:
Organization Name (eg, company) [Personal]:
Organizational Unit Name (eg, section) [Directorate]:
Common Name (e.g. server FQDN or YOUR name) [ca.personal.localhost]:
Email Address [info@ca.personal.localhost]:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:

  2.3. Создание сертификата с использованием CSR и ключа, а также подписывание сертификата с помощью корневого ключа ЦС: server.personal.localhost.crt
Certificate request self-signature ok
subject=C=RU, ST=Tula region, L=Tula, O=Personal, OU=Directorate, CN=ca.personal.localhost, emailAddress=info@ca.personal.localhost

  2.4. Проверка созданного сертификата: server.personal.localhost.crt
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            5d:8f:f2:64:51:93:6c:df:53:23:f2:4c:dc:47:ec:78:8c:ba:50:9d
        Signature Algorithm: ecdsa-with-SHA256
        Issuer: C=RU, ST=Tula region, L=Tula, O=Personal, OU=Directorate, CN=ca.personal.localhost, emailAddress=info@ca.personal.localhost
        Validity
            Not Before: Aug  1 16:44:05 2024 GMT
            Not After : Aug  1 16:44:05 2025 GMT
        Subject: C=RU, ST=Tula region, L=Tula, O=Personal, OU=Directorate, CN=ca.personal.localhost, emailAddress=info@ca.personal.localhost
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (256 bit)
                pub:
                    04:01:ef:cb:6e:80:93:3b:ad:61:1c:60:5a:57:22:
                    22:a1:61:fd:ed:cf:31:76:f6:ae:a0:dc:50:27:0b:
                    32:75:c1:f6:80:88:5f:3a:d7:93:56:ca:48:d5:a7:
                    aa:f9:71:e2:47:11:68:ff:28:73:76:2f:1c:da:a2:
                    ea:59:90:8d:e4
                ASN1 OID: prime256v1
                NIST CURVE: P-256
        X509v3 extensions:
            X509v3 Subject Key Identifier:
                81:24:56:D3:1A:EB:E2:67:BA:83:46:92:8E:AA:7E:22:EC:69:D9:B8
            X509v3 Authority Key Identifier:
                AD:DA:2E:C7:1B:5B:FA:B3:8E:24:B0:28:F7:2B:62:F5:1C:36:27:D0
    Signature Algorithm: ecdsa-with-SHA256
    Signature Value:
        30:46:02:21:00:fb:26:4d:cc:e5:aa:93:46:c6:0d:ab:88:cf:
        aa:ef:32:d3:6c:bc:97:fa:d9:0e:c2:16:ea:fc:ab:68:a1:b9:
        88:02:21:00:a3:82:47:33:96:eb:09:95:c6:12:e5:ea:a0:57:
        85:84:0f:59:42:11:db:ec:26:d1:b1:ad:5f:2e:f1:25:31:3d

Сгенерированные ключи были сохранены в папке keys
```
