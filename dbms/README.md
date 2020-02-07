## Предварительные работы
```
psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -f s_su/db.sql
```
$POSTGRES_HOST - адрес бд

$POSTGRES_PORT - порт бд

$POSTGRES_USER - супер пользователь

Cкрипт создает бд и супер пользователя s_su которому принадлежит бд, используется только для обновления. 
При необходимости надо сменить пароль

## Установка бд

Правим liquibase.properties прописываем адрес нашей бд и суперпользователя s_su

Запускаем 
```
update
```
Проверяем main.log

Пример успешного ответа:
```
Starting Liquibase at Пт, 10 янв 2020 09:00:24 MSK (version 3.6.3 built at 2019-01-29 11:34:48)
Liquibase: Update has been successful.
```