Универсальный шлюз проекта CORE

## Зависимости

1. `yarn` - (^1.13.0)
2. `node` - (^12.0.0)

## Сборки проекта 

`yarn build`

Соберает сборку в папку bin.

## Основные настройки переменного окружения

LOGGER_CONF - ссылка на файл ностроек логера logger.json

GATE_HOME_DIR - домашняя папкка сервера

GATE_CLUSTER_NUM - количество процессов node.js, по умолчанию количество ядер

GATE_HTTP_PORT - порт http кластера

GATE_UPLOAD_DIR - темповая папка загрузки файлов

NEDB_MULTI_PORT - порт доступа к сокету nedb 

NEDB_MULTI_HOST - ip адресс nedb

NEDB_TEMP_DB - темповая папка nedb

CONTEXT_PLUGIN_DIR - папка плагинов context по умолчанию $GATE_HOME_DIR/plugins/context

PROVIDER_PLUGIN_DIR - папка плагинов provider по умолчанию $GATE_HOME_DIR/plugins/provider

DATA_PLUGIN_DIR - папка плагинов data по умолчанию $GATE_HOME_DIR/plugins/data

EVENT_PLUGIN_DIR - папка плагинов event по умолчанию $GATE_HOME_DIR/plugins/event

SCHEDULER_PLUGIN_DIR - папка плагинов scheduler по умолчанию $GATE_HOME_DIR/plugins/scheduler

PROPERTY_DIR - путь до папки настроек шлюза

GATE_ADMIN_CLUSTER_CERT - сертификат сервера для межсетевого взаимодействия

GATE_ADMIN_CLUSTER_KEY - приватный ключ сервера для межсетевого взаимодействия

GATE_ADMIN_CLUSTER_CA - сертификат root

GATE_ADMIN_CLUSTER_PORT - порт межсетевого взаимодействия

GATE_NODE_NAME - наименование сервера по умолчанию имя машины