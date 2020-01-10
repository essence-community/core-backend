## Предварительные работы
```
psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U s_su -f s_su/db.sql
```
$POSTGRES_HOST - адрес бд
 
$POSTGRES_PORT - порт бд

## Установка бд

Правим liquibase.meta.properties прописываем адрес нашей бд core и суперпользователя s_su
Правим liquibase.integr.properties прописываем адрес нашей бд core_integr и суперпользователя s_su

Запускаем 
```
update
```
Проверяем main.log

Пример успешного ответа
```
Starting Liquibase at Пт, 10 янв 2020 09:00:24 MSK (version 3.6.3 built at 2019-01-29 11:34:48)
Liquibase: Update has been successful.
Starting Liquibase at Пт, 10 янв 2020 09:00:27 MSK (version 3.6.3 built at 2019-01-29 11:34:48)
Liquibase: Update has been successful.
```