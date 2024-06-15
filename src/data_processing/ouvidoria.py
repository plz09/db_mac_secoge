from ..utils.excel_operations import remove_espacos_e_acentos

def read_ouvidoria_data():
    path_ouvidoria = 'data_bruto/ouvidoria/Banco_de_Dados_Ouvidoria_do_SUS_Recife _2019_ate _o_dia_03_06_2024.xlsx'
    df_ouvidoria = remove_espacos_e_acentos(path_ouvidoria)
    return {'ouvidoria': df_ouvidoria}
