import sys
import os

# Adiciona o diretório raiz do projeto ao sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import create_engine_to_db, write_df_to_sql, connect_to_db, execute_query
from src.schema_creation import create_schemas
from src.data_processing import read_data_files
from src.spa_processing import process_spa_files
from src.unidades_mac import create_and_populate_unidades_mac
from src.mae_coruja_processing import process_mae_coruja_files

def main():
    # Conexão com o banco de dados PostgreSQL
    db_name = 'db_mac_secoge'
    user = 'secoge'
    password = 'secoge5437'
    host = 'localhost'
    port = 5432  # Porta mapeada do host

    engine = create_engine_to_db(db_name, user, password, host, port)

    # Criação dos esquemas
    create_schemas(engine)

    # Leitura dos arquivos e preparação dos dataframes
    dataframes = read_data_files()

    try:
        # Iterar sobre os esquemas e tabelas e escrever cada DataFrame no banco de dados
        for schema, tables in dataframes.items():
            for table_name, df in tables.items():
                print(f"Escrevendo a tabela {table_name} no esquema {schema}.")
                write_df_to_sql(df, table_name, engine, schema)

        # Cria e popula a tabela Unidades_mac
        create_and_populate_unidades_mac(engine)

        # Processa os arquivos SPA
        process_spa_files(engine)

        # Processa os arquivos mae_coruja_espacos
        process_mae_coruja_files(engine)

    finally:
        engine.dispose()

if __name__ == '__main__':
    main()
