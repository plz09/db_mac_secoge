from sqlalchemy import create_engine, text
import pandas as pd
import psycopg2

def create_engine_to_db(db_name, user, password, host='localhost', port=5432):
    """
    Cria um engine SQLAlchemy para o banco de dados PostgreSQL.
    """
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db_name}')
    return engine

def create_schemas(db_name, user, password, host='localhost', port=5432):
    """
    Cria schemas no banco de dados PostgreSQL, se não existirem.

    :param db_name: Nome do banco de dados
    :param user: Nome do usuário
    :param password: Senha do usuário
    :param host: Host do banco de dados
    :param port: Porta do banco de dados
    """
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
            dbname=db_name,
            user=user,
            password=password,
            host=host,
            port=port
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
        raise

def write_df_to_sql(df, table_name, engine, schema, if_exists='replace'):
    """
    Escreve um DataFrame no banco de dados PostgreSQL em um esquema específico e adiciona uma coluna SERIAL como chave primária.

    :param df: DataFrame a ser escrito no banco de dados
    :param table_name: Nome da tabela onde os dados serão inseridos
    :param engine: Engine SQLAlchemy
    :param schema: Nome do esquema onde a tabela será criada
    :param if_exists: Comportamento se a tabela já existir ('replace', 'append', 'fail')
    """
    primary_key = f"id_{table_name}"

    try:
        # Remover a coluna de chave primária se ela existir no DataFrame
        if primary_key in df.columns:
            df = df.drop(columns=[primary_key])

        # Criar a tabela no banco de dados
        df.to_sql(table_name, engine, if_exists=if_exists, index=False, schema=schema)
        print(f"Tabela {table_name} escrita no esquema {schema}.")

        # Adicionar a coluna SERIAL e definir como chave primária
        with engine.connect() as con:
            con.execute(text(f'ALTER TABLE {schema}.{table_name} ADD COLUMN {primary_key} SERIAL PRIMARY KEY;'))
        
        print(f"Tabela {table_name} no esquema {schema} atualizada com chave primária {primary_key}.")
    except Exception as e:
        print(f"Erro ao escrever a tabela {table_name} no esquema {schema}: {e}")
        raise

def connect_to_db(db_name, user, password, host='localhost', port=5432):
    """
    Conecta ao banco de dados PostgreSQL.
    """
    return create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db_name}').connect()

def execute_query(con, query):
    """
    Executa uma query SQL no banco de dados PostgreSQL.

    :param con: Objeto de conexão com o banco de dados PostgreSQL
    :param query: Query SQL a ser executada
    """
    with con.begin() as transaction:
        transaction.execute(text(query))
