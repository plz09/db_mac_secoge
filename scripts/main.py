import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import create_engine_to_db, write_df_to_sql
from src.data_processing import (
    read_unidades_data,
    read_producao_data,
    read_ouvidoria_data,
    read_horus_data,
    read_mae_coruja_data,
    process_mae_coruja_files,
    read_atende_gestante_data,
    read_atbasica_data
)

def main():
    db_name = 'db_mac_secoge'
    user = 'secoge'
    password = 'secoge5437'
    host = 'localhost'
    port = 5432

    engine = create_engine_to_db(db_name, user, password, host, port)

    schemas = {
        'unidades': read_unidades_data,
        'producao': read_producao_data,
        'ouvidoria': read_ouvidoria_data,
        'horus': read_horus_data,
        'mae_coruja': read_mae_coruja_data,
        'atende_gestante': read_atende_gestante_data,
        'atbasica': read_atbasica_data
    }

    try:
        for schema, read_data_func in schemas.items():
            data = read_data_func()
            for table_name, df in data.items():
                print(f"Escrevendo a tabela {table_name} no esquema {schema}.")
                write_df_to_sql(df, table_name, engine, schema)
        
        # Processa arquivos específicos do Mãe Coruja
        process_mae_coruja_files(engine)
    finally:
        engine.dispose()

if __name__ == '__main__':
    main()
