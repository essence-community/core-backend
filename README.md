# Ungate — универсальный шлюз CORE

HTTP-шлюз проекта Essence/CORE. Принимает запросы (`query` + `action`), прогоняет их через контексты и плагины и выполняет их у провайдеров (PostgreSQL, Oracle, REST, gRPC, Keycloak и др.).

Версия: **3.1.0**. Лицензия: MIT.

## Архитектура

Yarn-монорепозиторий. Ядро поднимает кластер Node.js-процессов (HTTP, admin, события, планировщик, локальная БД) и загружает плагины из каталогов.

| Каталог | Назначение |
| --- | --- |
| `server/` | Ядро: HTTP, сессии, админка, загрузка плагинов |
| `plugininf/` | Общие интерфейсы и утилиты плагинов |
| `contexts/` | Контексты (маршруты API, сессии, аудит) |
| `providers/` | Провайдеры данных и авторизации |
| `plugins/` | Data-плагины (SQL, файлы, патчи, отчёты) |
| `events/` | События (уведомления, семафоры, локализация) |
| `schedulers/` | Планировщики |
| `dbms*` | Liquibase-схемы PostgreSQL |
| `template/dbms/` | Шаблоны схем PostgreSQL и Oracle |
| `utils/gate-cli/` | CLI: пакеты и шифрование паролей |
| `openapi/` | OpenAPI 3-спецификация API |

Запрос идёт в контекст по `cv_path` (по умолчанию `/api`), затем: сессия → плагины → провайдер. Действия: `sql`, `dml`, `auth`, `file`, `upload`, `getfile`.

Конфигурация — YAML в `resources/config/` (`t_context.yaml`, `t_providers.yaml`, `t_plugins.yaml`, `t_query.yaml`, `t_events.yaml`, `t_schedulers.yaml`). Логер — `logger.json`. Старый формат TOML не используйте: `gate-cli` умеет конвертировать `.toml` → `.yaml`.

Подробнее: [каталог плагинов](docs/README.md).

## Требования

- Node.js `>= 22`
- Yarn `>= 1.22` (Classic / workspaces)
- PostgreSQL — для схем CORE (Oracle поддерживается провайдерами и шаблоном)

## Сборка и запуск

```bash
yarn install
yarn build
```

Сборка (`gulp all`) пишет артефакты в `bin/`. Выборочная сборка плагинов — через `CONTEXT_PLUGINS`, `PROVIDER_PLUGINS`, `DATA_PLUGINS`, `EVENT_PLUGINS`, `SCHEDULERS_PLUGINS` (имена через запятую, без учёта регистра).

Запуск из артефакта:

```bash
cd bin
yarn install
yarn server
```

HTTP по умолчанию слушает порт **8080**. Каталог конфигов задайте через `PROPERTY_DIR` (сборка не копирует `resources/` в `bin/`).

Очистка: `yarn clear` (удаляет `bin/`).

## Установка БД

Схемы накатываются Liquibase-скриптами `update` / `update.bat`. Порядок: сначала `dbms`, затем зависимые схемы.

| Схема | Описание |
| --- | --- |
| [dbms](dbms/README.md) | Основная схема CORE (мета, страницы, запросы) |
| [dbms_auth](dbms_auth/README.md) | Авторизация |
| [dbms_integration](dbms_integration/README.md) | Интеграция |
| [dbms_session](dbms_session/README.md) | Сессии (TypeORM) |
| [dbms_audit](dbms_audit/README.md) | Аудит |
| [dbms_bpmn_integration](dbms_bpmn_integration/README.md) | BPMN-интеграция |
| [dbms_user_cache_redis](dbms_user_cache_redis) | Кэш пользователей в Redis |
| [template/dbms/postgresql](template/dbms/postgresql/README.md) | Шаблон прикладной схемы PostgreSQL |
| [template/dbms/oracle](template/dbms/oracle/README.md) | Шаблон прикладной схемы Oracle |

## Переменные окружения

Значения по умолчанию — из кода. Путь или содержимое: `ESSENCE_PW_*` можно задать строкой или путём к файлу.

### Процессы и HTTP

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `GATE_HOME_DIR` | каталог сервера | Домашняя папка шлюза |
| `GATE_CLUSTER_NUM` | число CPU | Число HTTP-воркеров |
| `GATE_HTTP_PORT` | `8080` | Порт HTTP |
| `GATE_UPLOAD_DIR` | системный tmp | Каталог загрузок (`upload_ungate`) |
| `GATE_LOCAL_DB` | `nedb` | Локальное хранилище настроек |
| `GATE_NODE_NAME` | hostname | Имя ноды |
| `GATE_DEFAULT_TIMEZONE_DATE` | `Europe/Moscow` | Таймзона дат в JSON |
| `GATE_JSON_DATE_FORMAT` | `YYYY-MM-DDTHH:mm:ss` | Формат дат в JSON |
| `LOGGER_CONF` | `$GATE_HOME_DIR/resources/config/logger.json` | Конфиг логера |
| `PROPERTY_DIR` | `$GATE_HOME_DIR/resources/config` | Каталог настроек шлюза |
| `SESSION_SECRET` | встроенный | Секрет подписи сессии |

### Плагины

| Переменная | По умолчанию |
| --- | --- |
| `CONTEXT_PLUGIN_DIR` | `$GATE_HOME_DIR/plugins/contexts` |
| `PROVIDER_PLUGIN_DIR` | `$GATE_HOME_DIR/plugins/providers` |
| `DATA_PLUGIN_DIR` | `$GATE_HOME_DIR/plugins/datas` |
| `EVENT_PLUGIN_DIR` | `$GATE_HOME_DIR/plugins/events` |
| `SCHEDULER_PLUGIN_DIR` | `$GATE_HOME_DIR/plugins/schedulers` |

### NeDB (локальная БД)

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `NEDB_MULTI_PORT` | `33030` | Порт сокета NeDB |
| `NEDB_MULTI_HOST` | `127.0.0.1` | Хост NeDB |
| `NEDB_TEMP_DB` | `<tmp>/db` | Каталог временных БД NeDB |

### Кластер (межпроцессное взаимодействие)

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `GATE_ADMIN_CLUSTER_PORT` | `43090` | Порт admin-кластера |
| `GATE_ADMIN_CLUSTER_CERT` | `$GATE_HOME_DIR/cert/server.crt` | Сертификат |
| `GATE_ADMIN_CLUSTER_KEY` | `$GATE_HOME_DIR/cert/server.key` | Ключ |
| `GATE_ADMIN_CLUSTER_CA` | `$GATE_HOME_DIR/cert/ca.crt` | CA |

### Шифрование паролей

| Переменная | Описание |
| --- | --- |
| `ESSENCE_PW_KEY_SECRET` | AES-ключ (строка или файл) |
| `ESSENCE_PW_SALT` | Соль AES |
| `ESSENCE_PW_DEFAULT_ALG` | Алгоритм (`aes-256-gcm` при наличии ключа) |
| `ESSENCE_PW_RSA` | RSA private key (строка или файл) |
| `ESSENCE_PW_RSA_PASSPHRASE` | Passphrase RSA-ключа |

Те же переменные использует [gate-cli](utils/gate-cli/README.md).

В Kubernetes контекст `KubeProbe` и discovery нод читают стандартные `KUBERNETES_*` / `OPENSHIFT_KUBE_PING_*`.

## CLI

```bash
yarn create @essence-community/gate-cli
```

Создание пакетов (Oracle/Postgres) и шифрование паролей: [utils/gate-cli](utils/gate-cli/README.md).

## Документация

- [Плагины, провайдеры, контексты](docs/README.md)
- [OpenAPI](openapi/openapi.yml)
- [RestTransformProxy](docs/providers/RestTransformProxy.md)
- [GRpcTransformProxy](docs/providers/GRpcTransformProxy.md)
- [KeyCloakAuth](docs/providers/KeyCloakAuth.md)
