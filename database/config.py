import hvac
import os

VAULT_ADDR = os.getenv("VAULT_ADDR", "http://127.0.0.1:8200")
VAULT_TOKEN = os.getenv("VAULT_TOKEN", "root")

client = hvac.Client(
    url=VAULT_ADDR,
    token=VAULT_TOKEN
)

read_response = client.secrets.kv.v2.read_secret_version(path='database')
secrets = read_response['data']['data']

DB_HOST = secrets.get("DB_HOST")
DB_NAME = secrets.get("DB_NAME")
DB_USER = secrets.get("DB_USER")
DB_PASS = secrets.get("DB_PASS")
DB_PORT = secrets.get("DB_PORT")