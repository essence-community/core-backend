# Провайдер авторизации KeyCloak

## 1. Подключение провайдера
Пример настроек t_providers.yaml
```yaml
- ck_id: keycloak
  cl_autoload: 0
  ck_d_plugin: keycloakauth
  cv_description: ''
  cct_params:
    keyCloakParamName: jt_keycloak
    onlySession: false
    sessionDuration: 60
    idKey: ck_id
    typeCheckAuth: cookieorsession
    redirectUrl: http://localhost:9020/auth/home
    disableRecursiveAuth: true
    flagRedirect: jl_keycloak_auth_callback
    mapKeyCloakUserInfo:
      - in: sub
        out: ck_id
      - in: given_name
        out: cv_name
      - in: name
        out: cv_full_name
      - in: preferred_username
        out: cv_login
      - in: family_name
        out: cv_surname
      - in: email
        out: cv_email
      - in: ca_department
        out: ca_department
    grantManagerConfig:
      clientId: essence_gui
      realmUrl: http://localhost:10080/auth/realms/CHAT
      secret: ri60fB6loy6YHoJRkjrYQ4w9rR98K0lK
      public: false
      bearerOnly: true
      proxyUrl: http://keycloak:9020/auth/realms/CHAT
    mapKeyCloakGrantRole:
      - grant: realm:ROLE_ADMIN
        role: Администратор # Роль локальной авторизации
    mapKeyCloakGrant:
      - grant: realm:ROLE_ADMIN
        action: 514
    adminPathParam: jv_keycloak_path_callback
```
![Пример](./images/settings-keycloak.png)

## 2. Переключение авторизации фронта
```sql
UPDATE s_mt.t_query
	SET ck_provider='keycloak'
	WHERE ck_id='Login';
```

## 3. Включаение синхронизации с локальной авторизацией
```yaml
- ck_id: authcore
  cl_autoload: 1
  ck_d_plugin: coreauthpg
  cv_description: Провайдер внутренней авторизации
  cct_params:
    connectString: postgres://s_ac:s_ac@postgres:5432/core_auth
    poolMax: 10
    addedExternal: true
```

addedExternal - включает импорт пользователей из других провайдеров