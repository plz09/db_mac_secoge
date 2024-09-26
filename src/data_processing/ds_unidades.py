import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos

def read_ds_unidades_data():
    path_rede_saude_geo = '/Shared Documents/SESAU/NGI/data_bruto_mac/ds_unidades/REDE_SAUDE_RECIFE_GEO.xlsx'
    #path_rede_saude_geo = 'data_bruto/ds_unidades/unidades.xlsx'

    df_unidades = get_file_as_dataframes(path_rede_saude_geo, sheet_name='UNIDADES')
    df_unidades = remove_espacos_e_acentos(df_unidades)
    
    path_ds_tab = '/Shared Documents/SESAU/NGI/data_bruto_mac/ds_unidades/tab_DS.xlsx'

    df_ds = get_file_as_dataframes(path_ds_tab)
    df_ds = remove_espacos_e_acentos(df_ds)
    
    path_login_unidades = '/Shared Documents/SESAU/NGI/data_bruto_mac/ds_unidades/login_unidades.xlsx'

    df_login_unidades = get_file_as_dataframes(path_login_unidades)
    df_login_unidades = remove_espacos_e_acentos(df_login_unidades)

    path_login_ds = '/Shared Documents/SESAU/NGI/data_bruto_mac/ds_unidades/login_ds.xlsx'

    df_login_ds = get_file_as_dataframes(path_login_ds)
    df_login_ds = remove_espacos_e_acentos(df_ds)

    return {
        'unidades': df_unidades, 
        'distritos': df_ds,
        'login_unidades': df_login_unidades,
        'login_ds': df_login_ds
        }

