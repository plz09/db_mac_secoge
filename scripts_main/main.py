import os
import sys
from contextlib import contextmanager

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import create_engine_to_db, write_df_to_sql, create_schemas
from src.data_processing import get_data_processing_functions
from src.sql_operations.sql_operations import execute_sql_script, get_script_path

@contextmanager
def db_connection(config):
    engine = create_engine_to_db(config['db_name'], config['user'], config['password'], config['host'], config['port'])
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

def run_scripts(config, script_dirs_and_files):
    script_paths = []
    for base_dir, scripts in script_dirs_and_files.items():
        script_paths.extend(get_script_path(base_dir, scripts))
    
    for script_path in script_paths:
        execute_sql_script(config['db_name'], config['user'], config['password'], config['host'], config['port'], script_path)

def main():
    config = {
        'db_name': 'db_mac_secoge',
        'user': 'postgres',
        'password': 'secoge',
        'host': 'localhost',
        'port': 5432
    }

    script_dirs_and_files = {
        'scripts_sql/relacionamentos_por_schemas': [
            'create_calendario.sql',
            'create_unidades_mac.sql',
            'rel_spa.sql',
            'rel_horus.sql',
            'rel_maternidades.sql',
            'rel_mae_coruja.sql',
            'rel_ouvidoria.sql',
            'rel_atende_gestante.sql',
            'rel_atbasica.sql',
            'rel_producao.sql'
        ],
        'scripts_sql/views_sql': [
            'views_mae_coruja.sql'
        ]
    }

    schemas = get_data_processing_functions()

    create_schemas(**config)

    try:
        with db_connection(config) as engine:
            process_data(schemas, engine)
            run_scripts(config, script_dirs_and_files)
    except Exception as error:
        print(f"Erro ao processar função: {error}")

if __name__ == '__main__':
    main()
