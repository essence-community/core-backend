# Плагины Ungate

Плагины подключаются в YAML (`ck_d_plugin` — имя класса плагина). Каталоги исходников: `contexts/`, `providers/`, `plugins/`, `events/`, `schedulers/`.

## Контексты (`contexts/`)

| Плагин | Описание |
| --- | --- |
| CorePGContext | Контекст конструктора на PostgreSQL |
| CoreOracleContext | Контекст конструктора на Oracle |
| CorePGIntegrationContext | Контекст интеграции (PostgreSQL) |
| CoreOracleIntegrationContext | Контекст интеграции (Oracle) |
| KubeProbe | Kubernetes liveness/readiness |

## Провайдеры (`providers/`)

| Плагин | Описание |
| --- | --- |
| PostgreSQLDb | Подключение к PostgreSQL |
| OracleDb | Подключение к Oracle |
| CoreAuthPG | Авторизация CORE (PostgreSQL) |
| CoreAuthOracle | Авторизация CORE (Oracle) |
| [KeyCloakAuth](providers/KeyCloakAuth.md) | Авторизация Keycloak |
| TokenBearerAuth | Авторизация JWT Bearer |
| AdAuth | Авторизация Active Directory |
| PKOAuth | Авторизация PKO |
| AuthCrmWs | Авторизация CRM WS |
| AuthMock | MOCK-авторизация |
| CorePGIntegration | Интеграция (PostgreSQL) |
| CoreOracleIntegration | Интеграция (Oracle) |
| [RestTransformProxy](providers/RestTransformProxy.md) | Вызов внешних REST-сервисов |
| [GRpcTransformProxy](providers/GRpcTransformProxy.md) | Вызов внешних gRPC-сервисов |
| RestEssenceProxy | Прокси Essence REST |
| ProxyTransparent | Прозрачный HTTP-прокси |
| Redis | Провайдер Redis |

Дополнительно: [KeyCloakAuth (nginx)](../providers/KeyCloakAuth/README.md), [TokenBearerAuth](../providers/TokenBearerAuth/README.md).

## Data-плагины (`plugins/`)

| Плагин | Описание |
| --- | --- |
| PrepareQuery | Модификация SQL |
| PQAddedDefaultPaginationAndFilter | Пагинация и фильтры SQL |
| Encoder | Преобразование форматов (XML, YAML, Base64) |
| JsonRowColumnExtractor | Распаковка JSON |
| ExtractorFileToJson | Табличные файлы (xlsx/csv/dbf) → JSON |
| GridToExcel | Выгрузка грида в Excel |
| AssetsStorage | Файлы в локальном хранилище |
| S3Storage | Файлы в S3 |
| ModuleStorage | Сохранение и обработка модулей |
| Patcher | Формирование патча системы |
| OPARender | Open Policy Agent (Rego) |
| EssenceReportIntegration | Интеграция Essence Report |
| USPOIntegration | Интеграция УСПО |

## События (`events/`)

| Плагин | Описание |
| --- | --- |
| CorePgNotification | Оповещения PostgreSQL |
| CoreOracleNotification | Оповещения Oracle |
| CorePgSemaphore | Семафор PostgreSQL |
| CoreOracleSemaphore | Семафор Oracle |
| CorePgLocalization | Локализация (PostgreSQL) |
| CheckEssenceUpdatePG | Проверка обновлений БД |

## Планировщики (`schedulers/`)

| Плагин | Описание |
| --- | --- |
| ReloadProvider | Перезагрузка провайдеров |
