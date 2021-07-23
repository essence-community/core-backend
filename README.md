# Универсальный шлюз проекта CORE

## Установка БД

[Основная схема CORE](dbms/README.md)

[Основная схема Авторизации](dbms_auth/README.md)

[Основная схема Интеграция](dbms_integration/README.md)

## Сборка и установка шлюза 
### Зависимости

1. `yarn` - (^1.13.0)
2. `node` - (^12.0.0)

### Сборки проекта 

```yarn build```

Собирает в папку bin.

### Основные настройки переменного окружения

LOGGER_CONF - ссылка на файл настроек логера logger.json

GATE_HOME_DIR - домашняя папка сервера

GATE_CLUSTER_NUM - количество процессов node.js. По умолчанию: количество ядер

GATE_HTTP_PORT - порт http кластера

GATE_UPLOAD_DIR - темповая папка загрузки файлов

NEDB_MULTI_PORT - порт доступа к сокету nedb 

NEDB_MULTI_HOST - ip адрес nedb

NEDB_TEMP_DB - темповая папка nedb

CONTEXT_PLUGIN_DIR - папка плагинов context. По умолчанию: $GATE_HOME_DIR/plugins/context

PROVIDER_PLUGIN_DIR - папка плагинов provider. По умолчанию: $GATE_HOME_DIR/plugins/provider

DATA_PLUGIN_DIR - папка плагинов data. По умолчанию: $GATE_HOME_DIR/plugins/data

EVENT_PLUGIN_DIR - папка плагинов event. По умолчанию: $GATE_HOME_DIR/plugins/event

SCHEDULER_PLUGIN_DIR - папка плагинов scheduler. По умолчанию: $GATE_HOME_DIR/plugins/scheduler

PROPERTY_DIR - путь до папки настроек шлюза

GATE_ADMIN_CLUSTER_CERT - сертификат сервера для межсетевого взаимодействия

GATE_ADMIN_CLUSTER_KEY - приватный ключ сервера для межсетевого взаимодействия

GATE_ADMIN_CLUSTER_CA - сертификат root

GATE_ADMIN_CLUSTER_PORT - порт межсетевого взаимодействия

GATE_NODE_NAME - наименование сервера. По умолчанию: имя машины

# Документация
[Описание доступных плагинов](docs/README.md)