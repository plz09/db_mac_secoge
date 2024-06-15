import sqlite3
import pandas as pd

def connect_to_db(db_name='db_mac.sqlite'):
    """
    Conecta ao banco de dados SQLite.

    :param db_name: Nome do arquivo do banco de dados
    :return: Objeto de conexão com o banco de dados SQLite
    """
    return sqlite3.connect(db_name)

def write_df_to_sql(df, table_name, con, if_exists='replace', dtype=None):
    """
    Escreve um DataFrame no banco de dados SQLite.

    :param df: DataFrame a ser escrito no banco de dados
    :param table_name: Nome da tabela onde os dados serão inseridos
    :param con: Objeto de conexão com o banco de dados SQLite
    :param if_exists: Comportamento se a tabela já existir ('replace', 'append', 'fail')
    :param dtype: Especificação dos tipos de dados das colunas (opcional)
    """
    if isinstance(df, pd.DataFrame):
        df.to_sql(table_name, con, if_exists='replace', index=False, dtype=dtype)
    else:
        raise ValueError(f"Esperado um DataFrame, mas recebeu {type(df)}")

def write_data_to_database(dataframes, con):
    # Escrever os DataFrames no banco de dados SQLite
    for df_name, df in dataframes.items():
        write_df_to_sql(df, df_name, con)

def execute_query(con, query):
    """
    Executa uma query SQL no banco de dados SQLite.

    :param con: Objeto de conexão com o banco de dados SQLite
    :param query: Query SQL a ser executada
    """
    con.execute(query)
    con.commit()
