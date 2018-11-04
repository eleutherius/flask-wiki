title: Open SSL
tags: 

Необходимо сгенерировать сертификаты для работы почтового сервера. (для подключения пользователей с использованием SSL) Сгенерируем сертификаты
```shell
mkdir /etc/postfix/certs
cd /etc/postfix/certs
touch openssl.cnf
```
Впишем
``` python
[req]
default_bits = 4096                     # Длинна ключа в битах.
default_keyfile = key.pem               # Имя файла, в который будет записан закрытый ключ.
encrypt_key = no                        # Нам не нужно шифровать закрытый ключ паролем.
default_md = sha512                     # Алгоритм хеша.
x509_extensions = v3_req                # Включаем расширение V3.
prompt = no                             # Не нужно запрашивать данные у пользователя, мы всё пропишем здесь.
distinguished_name = req_distinguished_name         # Имя секции с данными (может быть любым).

[req_distinguished_name]
C = Country                             # Двухбуквенный код страны
L = Locality                            # Город
O = Organization                        # Название организации
CN = mail.example.com                   # Имя домена
emailAddress = postmaster@example.com   # Адрес электронной почты
# Можно ещё указать следующие поля:
# ST (State - штат, название провинции и т.п.)
# OU (Organizational Unit - название подразделения)

[v3_req]
# Список альтернативных имён. Можно указать прямо здесь, но это не
# удобно, особенно если их много, так что мы указываем название секции
# с именами.
subjectAltName = @alt_names

[alt_names]
# Имена. Можно указать хоть сколько, главное чтобы цифры после точки были разными.
DNS.0 = example.com
DNS.1 = www.example.com
```
Естественно, заменив значения на свои. Теперь сообственно сгенерируем сами сертификаты
```
openssl req -new -x509 -days 36500 -config openssl.cnf -out cert.pem -outform PEM -keyout key.pem -keyform PEM
```
Удалим файл настроек