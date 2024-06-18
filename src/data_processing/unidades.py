from ..utils.excel_operations import remove_espacos_e_acentos

def read_unidades_data():
    #path_rede_saude_geo = 'data_bruto/unidades/REDE_SAUDE_RECIFE_GEO.xlsx'
    path_rede_saude_geo = 'data_bruto/unidades/unidades.xlsx'
    df_unidades = remove_espacos_e_acentos(path_rede_saude_geo, aba_selecionada='UNIDADES')
    return {'unidades': df_unidades}
