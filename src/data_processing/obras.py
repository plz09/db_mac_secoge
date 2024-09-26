import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos


def read_obras_data():
    url_obras = '/Shared Documents/SESAU/NGI/data_bruto_mac/obras/BASE PLANEJAMENTO SEINFRA REV114 - 26 DE AGOSTO DE 2024.xlsx'
    df_obras = get_file_as_dataframes(url_obras, sheet_name='BASE INFRA', skiprows=1)
    df_obras = remove_espacos_e_acentos(df_obras)

    return {'obras': df_obras}

    
