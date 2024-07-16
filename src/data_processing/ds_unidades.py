from ..utils.excel_operations import remove_espacos_e_acentos

def read_ds_unidades_data():
    path_rede_saude_geo = 'data_bruto/ds_unidades/REDE_SAUDE_RECIFE_GEO.xlsx'
    #path_rede_saude_geo = 'data_bruto/unidades/unidades.xlsx'
    path_ds_tab = 'data_bruto/ds_unidades/tab_DS.xlsx'
    df_unidades = remove_espacos_e_acentos(path_rede_saude_geo, aba_selecionada='UNIDADES')
    df_ds = remove_espacos_e_acentos(path_ds_tab)
    path_login_unidades = 'data_bruto/ds_unidades/login_unidades.xlsx'
    df_login_unidades = remove_espacos_e_acentos(path_login_unidades)
    return {
        'unidades': df_unidades, 
        'distritos': df_ds,
        'login_unidades': df_login_unidades
        }

