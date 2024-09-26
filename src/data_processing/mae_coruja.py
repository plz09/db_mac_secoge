import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos
from src.database.database import write_df_to_sql

def process_mae_coruja_data(engine):
    schema = 'mae_coruja'

    paths = {
        'mulher': '/Shared Documents/SESAU/NGI/data_bruto_mac/mae_coruja/DADOS MULHER.xlsx',
        'crianca': '/Shared Documents/SESAU/NGI/data_bruto_mac/mae_coruja/DADOS CRIANÇA.xlsx',
        'kits': ('/Shared Documents/SESAU/NGI/data_bruto_mac/mae_coruja/consolidado_kits_pmcr.xlsx', '2024'),
        'atividades': ('/Shared Documents/SESAU/NGI/data_bruto_mac/mae_coruja/consolidado_atividades_coletivas_pmcr.xlsx', 'atv_cltv_2018_2023', 11)
    }

    # Processar cada conjunto de dados
    data = {}
    for key, value in paths.items():
        if isinstance(value, tuple):
            # Desempacotar informações se forem fornecidos caminho, aba e, opcionalmente, linhas para pular
            path, aba, *skiprows = value
            df = get_file_as_dataframes(path, sheet_name=aba, skiprows=skiprows[0] if skiprows else 0)
        else:
            # Carregar a primeira aba disponível se não especificado
            df = get_file_as_dataframes(value)
        
        if df is not None:
            df = remove_espacos_e_acentos(df)
            data[key] = df

    # Escrever dataframes no banco de dados
    for table_name, df in data.items():
        if df is not None:
            print(f"Escrevendo a tabela {table_name} no esquema {schema}.")
            write_df_to_sql(df, table_name, engine, schema)
        else:
            print(f"Nenhum dado disponível para escrever para a tabela {table_name}.")

    # Processamento adicional dos arquivos específicos
    path_mae_coruja_espacos = '/Shared Documents/SESAU/NGI/data_bruto_mac/mae_coruja/Listagem_Espacos_PMCR_endereco_bairros_cobertos.xlsx'
    abas_mae_coruja_espacos = [
        ('ESPACOS', 5, ['ESPAÇO', 'DS', 'SIGLA', 'LOCAL', 'ENDEREÇO', 'BAIRROS COBERTOS',
                        'UNIDADES COBERTAS', 'DATA INAUGURAÇÃO ESPAÇO PMCR']),
        'Espaços_Unidades',
        'Espaços_Bairros_Cobertos'
    ]

    for item in abas_mae_coruja_espacos:
        if isinstance(item, tuple):
            aba, skiprows, colunas = item
        else:
            aba, skiprows, colunas = item, 0, None

        df = get_file_as_dataframes(path_mae_coruja_espacos, sheet_name=aba, skiprows=skiprows)
        if df is not None:
            df = remove_espacos_e_acentos(df) if colunas is None else remove_espacos_e_acentos(df[colunas])
            table_name = aba.lower().replace(' ', '').replace('-', '').replace('ç', 'c')
            write_df_to_sql(df, table_name, engine, schema)
        else:
            print(f"Erro ao processar a aba {aba}: DataFrame não carregado.")
