from ..utils.excel_operations import remove_espacos_e_acentos

def read_ouvidoria_data():
    path_ouvidoria = 'data_bruto/ouvidoria/Banco de Dados_Ouvidoria do SUS - Recife - 2019 até o dia 26.08.2024.xlsx'
    df_ouvidoria = remove_espacos_e_acentos(path_ouvidoria)
    return {'ouvidoria': df_ouvidoria}
