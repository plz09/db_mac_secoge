import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos
def read_atbasica_data():
    path_ATBasica_puericultura = '/Shared Documents/SESAU/NGI/data_bruto_mac/atencao_basica/Consulta Puericultura 2023 a 2024_31_05.xlsx'
    path_ATBasica_puerperal = '/Shared Documents/SESAU/NGI/data_bruto_mac/atencao_basica/Consulta Puerperal 2023 a 2024_31_05.xlsx'
    path_ATBasica_ifo_gestantes = '/Shared Documents/SESAU/NGI/data_bruto_mac/atencao_basica/Informações Gestantes 2024_31_05.xlsx'
    aba_info_gestate_planilha_calculo = 'Planilha Calculo'
    path_ATBasica_qttativos_gestantes_acompanhadas = '/Shared Documents/SESAU/NGI/data_bruto_mac/atencao_basica/Quantitativo de Gestantes Acompanhadas.xlsx'


    df_ATBasica_puericultura = get_file_as_dataframes(path_ATBasica_puericultura)
    df_ATBasica_puericultura = remove_espacos_e_acentos(df_ATBasica_puericultura)

    df_ATBasica_puerperal = get_file_as_dataframes(path_ATBasica_puerperal)
    df_ATBasica_puerperal = remove_espacos_e_acentos(df_ATBasica_puerperal)

    df_ATbasica_info_gestantes = get_file_as_dataframes(path_ATBasica_ifo_gestantes, sheet_name=aba_info_gestate_planilha_calculo)
    df_ATbasica_info_gestantes = remove_espacos_e_acentos(df_ATbasica_info_gestantes)

    df_qttativos_gestantes_acompanhadas = get_file_as_dataframes(path_ATBasica_qttativos_gestantes_acompanhadas)
    df_qttativos_gestantes_acompanhadas = remove_espacos_e_acentos(df_qttativos_gestantes_acompanhadas)

    return {
        'consulta_puericultura': df_ATBasica_puericultura,
        'consulta_puerperal': df_ATBasica_puerperal,
        'consulta_prenatal': df_ATbasica_info_gestantes,
        'quantitativo_gestantes_acompanhadas': df_qttativos_gestantes_acompanhadas
    }
