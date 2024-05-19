#!/bin/sh

# Получение секретов из Vault
DB_USER=$(curl -s --header "X-Vault-Token: $VAULT_TOKEN" $VAULT_ADDR/v1/secret/data/database | jq -r '.data.data.DB_USER')
DB_PASS=$(curl -s --header "X-Vault-Token: $VAULT_TOKEN" $VAULT_ADDR/v1/secret/data/database | jq -r '.data.data.DB_PASS')

# Создание файла с переменными окружения для PostgreSQL
echo "POSTGRES_USER=$DB_USER" > /scripts/postgres-init.sh
echo "POSTGRES_PASSWORD=$DB_PASS" >> /scripts/postgres-init.sh

# Добавление команды для запуска PostgreSQL
echo "/docker-entrypoint.sh postgres" >> /scripts/postgres-init.sh

# Выдача прав на выполнение скрипта
chmod +x /scripts/postgres-init.sh

# Завершение работы контейнера dockerize
exit 0
