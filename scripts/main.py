import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import create_engine_to_db, write_df_to_sql, create_schemas
from src.data_processing import (
    read_unidades_data,
    read_producao_data,
    read_ouvidoria_data,
    read_horus_data,
    process_mae_coruja_data,
    read_atende_gestante_data,
    read_atbasica_data,
    process_spa_files
)

def main():
    db_name = 'db_mac_secoge'
    user = 'postgres'
    password = 'secoge'
    host = 'localhost'
    port = 5432
    create_schemas(db_name, user, password, host, port)  # Chama a função para criar schemas

    engine = create_engine_to_db(db_name, user, password, host, port)

    schemas = {
        'unidades': read_unidades_data,
        'producao': read_producao_data,
        'ouvidoria': read_ouvidoria_data,
        'horus': read_horus_data,
        'mae_coruja': process_mae_coruja_data,
        'atende_gestante': read_atende_gestante_data,
        'atbasica': read_atbasica_data,
        'spa': process_spa_files
    }

    try:
        for schema, read_data_func in schemas.items():
            if schema == 'mae_coruja' or schema == 'spa':
                read_data_func(engine)  # processa e escreve diretamente no banco de dados
            else:
                data = read_data_func()
                for table_name, df in data.items():
                    print(f"Escrevendo a tabela {table_name} no esquema {schema}.")
                    write_df_to_sql(df, table_name, engine, schema)
    finally:
        engine.dispose()

if __name__ == '__main__':
    main()
