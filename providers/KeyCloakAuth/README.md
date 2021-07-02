
ADMIN KEYCLOCK NEED

add nginx
```
 location ~ "/keyclock/(.+)$" {
            proxy_pass http://gate:8080/api?jv_keyclock_path_callback=$1;
        }
```

query param jl_keyclock_use_redirect=1 response http code 301 and location