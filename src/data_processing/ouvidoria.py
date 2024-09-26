import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos


def read_ouvidoria_data():
    path_ouvidoria = '/Shared Documents/SESAU/NGI/data_bruto_mac/ouvidoria/Banco de Dados_Ouvidoria do SUS - Recife - 2019 até o dia 26.08.2024.xlsx'

    df_ouvidoria = get_file_as_dataframes(path_ouvidoria, sheet_name='Planilha1')
    df_ouvidoria = remove_espacos_e_acentos(df_ouvidoria)
    
    return {'ouvidoria': df_ouvidoria}
