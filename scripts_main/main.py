import sys
import os
from contextlib import contextmanager

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import create_engine_to_db, write_df_to_sql, create_schemas
from src.data_processing import get_data_processing_functions
from src.sql_operations.sql_operations import execute_sql_script, get_script_path

@contextmanager
def db_connection(db_name, user, password, host, port):
    engine = create_engine_to_db(db_name, user, password, host, port)
    try:
        yield engine
    finally:
        engine.dispose()    

def process_data(schemas, engine):
    for schema, read_data_func in schemas.items():
        if schema in ['mae_coruja', 'spa', 'maternidades']:
            read_data_func(engine)
        else:
            data = read_data_func()
            for table_name, df in data.items():
                print(f"Escrevendo a tabela {table_name} no esquema {schema}.")
                write_df_to_sql(df, table_name, engine, schema)

def run_scripts(db_name, user, password, host, port):
    script_path = get_script_path('create_unidades_mac.sql')
    execute_sql_script(db_name, user, password, host, port, script_path)

def main():
    config = {
        'db_name': 'db_mac_secoge',
        'user': 'postgres',
        'password': 'secoge',
        'host': 'localhost',
        'port': 5432
    }

    schemas = get_data_processing_functions()

    create_schemas(**config)

    try:
        with db_connection(**config) as engine:
            process_data(schemas, engine)
            run_scripts(**config)
    except Exception as error:
        print(f"Erro ao processar função data_data_func: {error}")

if __name__ == '__main__':
    main()
