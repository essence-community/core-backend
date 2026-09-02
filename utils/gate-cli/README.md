# gate-cli

CLI для разработки Ungate: Liquibase-пакеты PostgreSQL/Oracle, шифрование паролей, конвертация конфигов TOML → YAML.

Пакет: `@essence-community/create-gate-cli` 1.0.8. Node.js `>= 22`, Yarn `>= 1.22`.

## Запуск

Интерактивное меню:

```
1 - DBMS PostgreSQL package
2 - DBMS Oracle package
3 - Encrypt password
4 - Decrypt password
5 - Move property TOML to YAML
```

Через yarn create:

```bash
yarn create @essence-community/gate-cli
```

Из репозитория:

```bash
cd utils/gate-cli
yarn install
yarn start
```

Переменные окружения читаются из `.env` в текущей директории (`dotenv`).

## Команды

### 1. PostgreSQL package

Каталог по умолчанию: `./dbms/package`.

- **Create package** — `pkg_<suffix>.sql` и `pkg_json_<suffix>.sql` (схемы Liquibase).
- **Create template function** — `f_modify_*`, `p_modify_*`, `p_lock_*` для указанной таблицы. Можно создать вместе с пакетом или дописать в существующие файлы.

### 2. Oracle package

Каталог по умолчанию: `./dbms/package`.

- **Create package** — `pkg_<suffix>.sql` и `pkg_json_<suffix>.sql` (Oracle packages).
- **Create template function** отдельно не реализован (только вместе с созданием пакета).

### 3–4. Encrypt / Decrypt password

Пароль вводится скрыто. Результат шифрования: `{<alg>}<hex>`.

Алгоритмы: `aes-128-gcm`, `aes-192-gcm`, `aes-256-gcm`, `aes-128-ccm`, `aes-192-ccm`, `aes-256-ccm`, `privatekey`.

### 5. TOML → YAML

Читает все `.toml` в указанном каталоге, пишет одноимённые `.yaml` (поле `data`). Опционально удаляет исходные `.toml`. Формат конфигов шлюза — YAML; TOML устарел.

## Переменные окружения

Значение — строка или путь к файлу. Без ключа шифрование недоступно.

| Переменная | Описание |
| --- | --- |
| `ESSENCE_PW_KEY_SECRET` | AES-ключ |
| `ESSENCE_PW_SALT` | Соль AES |
| `ESSENCE_PW_DEFAULT_ALG` | Алгоритм по умолчанию |
| `ESSENCE_PW_RSA` | RSA private key |
| `ESSENCE_PW_RSA_PASSPHRASE` | Passphrase RSA-ключа |

Если `ESSENCE_PW_DEFAULT_ALG` не задан: `privatekey` при наличии RSA, иначе `aes-256-gcm`.
