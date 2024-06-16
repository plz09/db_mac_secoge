#test_create_schema

import psycopg2

def create_schemas():
    commands = [
        "CREATE SCHEMA IF NOT EXISTS producao",
        "CREATE SCHEMA IF NOT EXISTS ouvidoria",
        "CREATE SCHEMA IF NOT EXISTS horus",
        "CREATE SCHEMA IF NOT EXISTS mae_coruja",
        "CREATE SCHEMA IF NOT EXISTS atende_gestante",
        "CREATE SCHEMA IF NOT EXISTS atbasica",
        "CREATE SCHEMA IF NOT EXISTS unidades",
        "CREATE SCHEMA IF NOT EXISTS spa"
    ]

    try:
        # Conectar ao banco de dados PostgreSQL
        conn = psycopg2.connect(
            dbname='db_mac_secoge',
            user='secoge',
            password='secoge5437',
            host='localhost',
            port=5432
        )
        cur = conn.cursor()

        # Executar cada comando SQL
        for command in commands:
            cur.execute(command)

        # Fechar a comunicação com o banco de dados PostgreSQL
        cur.close()
        conn.commit()
        conn.close()
        print("Schemas criados com sucesso.")
    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Erro ao criar schemas: {error}")

if __name__ == "__main__":
    create_schemas()
