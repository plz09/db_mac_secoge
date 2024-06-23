from sqlalchemy import create_engine, text
import pandas as pd
import psycopg2
from src.database import execute_query, create_engine_to_db

def create_unidades_mac(db_name, user, password, host='localhost', port=5432):
    """
    Cria a tabela unidades_mac no banco de dados PostgreSQL, se não existirem, e define 
    relacionamento com a tabela distritos.

    :param db_name: Nome do banco de dados
    :param user: Nome do usuário
    :param password: Senha do usuário
    :param host: Host do banco de dados
    :param port: Porta do banco de dados
    """
    commands = [
        """
        CREATE TABLE IF NOT EXISTS ds_unidades.unidades_mac (
            id_unidades_mac SERIAL PRIMARY KEY,
            cnes_padrao INTEGER,
            codigo_unidade INTEGER,
            distrito INTEGER,
            nome CHARACTER VARYING,
            tipo_servi CHARACTER VARYING
        );
        """,
        """
        INSERT INTO ds_unidades.unidades_mac (cnes_padrao, codigo_unidade, distrito, nome, tipo_servi)
        SELECT cnes_padrao, no_da_us, ds, nome_fantasia, tipo_servi
        FROM ds_unidades.unidades
        """,
        """
        ALTER TABLE ds_unidades.unidades_mac
        ADD COLUMN IF NOT EXISTS fk_distritos INTEGER;
        """,
        """
        UPDATE ds_unidades.unidades_mac tab_mac
        SET fk_distritos = tab_ds.id_distritos
        FROM ds_unidades.distritos tab_ds
        WHERE tab_mac.distrito = tab_ds.ds;
        """,
        """
        ALTER TABLE ds_unidades.unidades_mac
        ADD CONSTRAINT IF NOT EXISTS fk_distritos FOREIGN KEY (fk_distritos) REFERENCES ds_unidades.distritos(id_distritos);
        """
    ]

    try:
        # Conectar ao banco de dados PostgreSQL usando SQLAlchemy
        engine = create_engine_to_db(db_name, user, password, host, port)
        with engine.connect() as connection:
            for command in commands:
                connection.execute(text(command))
        print("Scripts de criação da tabela unidades_mac executados com sucesso.")
    except Exception as error:
        print(f"Erro ao executar scripts: {error}")
        raise

if __name__ == "__main__":
    create_unidades_mac('nome_do_banco', 'usuario', 'senha')
