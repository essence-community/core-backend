# RUN

yarn create @essence-community/gate-cli

# Function
- Create package (Oracle/Postgres)
- Encrypt/Decrypt password

# Environment

ESSENCE_PW_KEY_SECRET - key used aes encrypt(string or file)

ESSENCE_PW_SALT - salt used aes encrypt(string or file)

ESSENCE_PW_IV - initialization vector (IV) hex(string or file)

ESSENCE_PW_DEFAULT_ALG - default alg

ESSENCE_PW_RSA - private key(string or file)

ESSENCE_PW_RSA_PASSPHRASE - passphrase private key(string or file)
