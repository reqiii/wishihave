#!/bin/bash
set -e

echo "Checking if wishlist_db exists..."

# Подключаемся к базе данных postgres и проверяем наличие базы данных wishlist_db
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
    SELECT 'CREATE DATABASE wishlist_db'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'wishlist_db')\gexec
EOSQL

echo "Checking if wishlist table exists in wishlist_db..."

# Подключаемся к базе данных wishlist_db и проверяем наличие таблицы wishlist
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "wishlist_db" <<-EOSQL
    CREATE TABLE IF NOT EXISTS wishlist (
        user_id BIGINT NOT NULL,
        item TEXT NOT NULL
    );
EOSQL

echo "Initialization complete."
