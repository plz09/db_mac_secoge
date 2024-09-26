import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos

def read_producao_data():
    path_dFormaOrganiz = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/dFormaOrganiz.xlsx'
    path_fProfissionais = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/fProfissionais.xlsx'
    path_dCBO = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/dCBO.xlsx'
    path_dPort157 = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/dPort157.xlsx'
    path_fproducao_2405 = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/PAPE2405.csv'
    path_fproducao_2406 = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/PAPE2406.csv'
    path_fproducao_2407 = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/PAPE2407.csv'
    path_dextrato_profissionais_sus = '/Shared Documents/SESAU/NGI/data_bruto_mac/producao/dExtrato_Profissioais_SUS.xlsx'
    
    df_dFormaOrganiz = get_file_as_dataframes(path_dFormaOrganiz)
    df_dFormaOrganiz = remove_espacos_e_acentos(df_dFormaOrganiz)

    df_fProfissionais = get_file_as_dataframes(path_fProfissionais)
    df_fProfissionais = remove_espacos_e_acentos(df_fProfissionais)

    df_dCBO = get_file_as_dataframes(path_dCBO)
    df_dCBO = remove_espacos_e_acentos(df_dCBO)

    df_dPort157 = get_file_as_dataframes(path_dPort157)
    df_dPort157 = remove_espacos_e_acentos(df_dPort157)

    df_dextrato_profissionais_sus = get_file_as_dataframes(path_dextrato_profissionais_sus)
    df_dextrato_profissionais_sus = remove_espacos_e_acentos(df_dextrato_profissionais_sus)

    cols_fproducao = ['PA_CODUNI', 'PA_CMP', 'PA_CNSMED', 'PA_CBOCOD', 'PA_PROC_ID', 'PA_QTDAPR']

    df_fproducao_2405 = get_file_as_dataframes(path_fproducao_2405) 
    df_fproducao_2405 = df_fproducao_2405[cols_fproducao]
    df_fproducao_2405 = remove_espacos_e_acentos(df_fproducao_2405)

    df_fproducao_2406 = get_file_as_dataframes(path_fproducao_2406)
    df_fproducao_2406 = df_fproducao_2406[cols_fproducao]
    df_fproducao_2406 = remove_espacos_e_acentos(path_fproducao_2406)

    df_fproducao_2407 = get_file_as_dataframes(path_fproducao_2407)

    df_fproducao_2407 = df_fproducao_2407[cols_fproducao]
    df_fproducao_2407 = remove_espacos_e_acentos(path_fproducao_2407)
    df_fproducao = pd.concat([df_fproducao_2405, df_fproducao_2406, df_fproducao_2407], ignore_index=True)

    df_producao_agg = df_fproducao.groupby(
                                ['pa_coduni', 'pa_cmp', 'pa_proc_id', 'pa_cnsmed', 'pa_cbocod'], as_index=False
                                )['pa_qtdapr'].sum()

    return {
        'dformaorganiz': df_dFormaOrganiz,
        'fprofissionais': df_fProfissionais,
        'dcbo': df_dCBO,
        'dport157': df_dPort157,
        'fproducao2024': df_producao_agg,
        'dextrato_profissionais_sus': df_dextrato_profissionais_sus
    }
