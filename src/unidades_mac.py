from src.database import execute_query

def create_and_populate_unidades_mac(con):
    # Criar e popular a tabela Unidades_mac
    create_unidades_mac = '''
        CREATE TABLE IF NOT EXISTS Unidades_mac (
            CNES_PADRAO INTEGER,
            CODIGO_UNIDADE INTEGER,
            DISTRITO INTEGER,
            NOME TEXT,
            TIPO_SERVI TEXT
        );
    '''
    execute_query(con, create_unidades_mac)
    execute_query(con, 'DELETE FROM Unidades_mac;')
    insert_unidades_mac = '''
        INSERT INTO Unidades_mac (CNES_PADRAO, CODIGO_UNIDADE, DISTRITO, NOME, TIPO_SERVI)
        SELECT CNES_PADRAO, No_DA_US, DS, NOME_FANTASIA, TIPO_SERVI
        FROM Unidades;
    '''
    execute_query(con, insert_unidades_mac)