from pydantic import BaseSettings


class Settings(BaseSettings):
    postgres_user: str
    postgres_password: str
    db_host: str
    port: str
    postgres_db: str
    table_name: str
    url: str

    class Config:
        env_file = "credentials.env"


settings = Settings(_env_file='credentials.env')
