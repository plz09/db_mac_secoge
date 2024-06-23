from ..utils.excel_operations import remove_espacos_e_acentos
import psycopg2

def read_ds_unidades_data():
    path_rede_saude_geo = 'data_bruto/ds_unidades/REDE_SAUDE_RECIFE_GEO.xlsx'
    #path_rede_saude_geo = 'data_bruto/unidades/unidades.xlsx'
    path_ds_tab = 'data_bruto/ds_unidades/tab_DS.xlsx'
    df_unidades = remove_espacos_e_acentos(path_rede_saude_geo, aba_selecionada='UNIDADES')
    df_ds = remove_espacos_e_acentos(path_ds_tab)
    return {
        'unidades': df_unidades, 
        'distritos': df_ds
        }

def create_unidades_mac(db_name, user, password, host='localhost', port=5432):
    """
    Cria tabela unidades_mac no banco de dados PostgreSQL, se não existirem.

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
        """
    ]

    try:
        # Conectar ao banco de dados PostgreSQL
        conn = psycopg2.connect(
            dbname=db_name,
            user=user,
            password=password,
            host=host,
            port=port,
            options="-c client_encoding=UTF8"
        )
        conn.set_client_encoding('UTF8')
        cur = conn.cursor()

        # Executar cada comando SQL
        for command in commands:
            cur.execute(command)

        # Fechar a comunicação com o banco de dados PostgreSQL
        cur.close()
        conn.commit()
        conn.close()
        print("Tabela unidades_mac criada com sucesso.")
    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Erro ao criar tabela unidades_mac: {error}")
        raise
