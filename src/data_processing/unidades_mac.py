from src.database import execute_query

def create_and_populate_unidades_mac(engine):
    # Criar e popular a tabela Unidades_mac no esquema 'unidades_mac'
    schema = 'unidades_mac'
    create_schema = f'CREATE SCHEMA IF NOT EXISTS {schema};'
    create_unidades_mac = f'''
        CREATE TABLE IF NOT EXISTS {schema}.Unidades_mac (
            CNES_PADRAO INTEGER,
            CODIGO_UNIDADE INTEGER,
            DISTRITO INTEGER,
            NOME TEXT,
            TIPO_SERVI TEXT
        );
    '''
    delete_unidades_mac = f'DELETE FROM {schema}.Unidades_mac;'
    insert_unidades_mac = f'''
        INSERT INTO {schema}.Unidades_mac (CNES_PADRAO, CODIGO_UNIDADE, DISTRITO, NOME, TIPO_SERVI)
        SELECT CNES_PADRAO, No_DA_US, DS, NOME_FANTASIA, TIPO_SERVI
        FROM Unidades;
    '''
    with engine.connect() as connection:
        connection.execute(create_schema)
        connection.execute(create_unidades_mac)
        connection.execute(delete_unidades_mac)
        connection.execute(insert_unidades_mac)
