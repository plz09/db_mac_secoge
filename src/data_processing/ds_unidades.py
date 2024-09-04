from ..utils.excel_operations import remove_espacos_e_acentos

def read_ds_unidades_data():
    path_rede_saude_geo = 'data_bruto/ds_unidades/REDE_SAUDE_RECIFE_GEO.xlsx'
    #path_rede_saude_geo = 'data_bruto/ds_unidades/unidades.xlsx'
    df_unidades = remove_espacos_e_acentos(path_rede_saude_geo, aba_selecionada='UNIDADES')
    
    path_ds_tab = 'data_bruto/ds_unidades/tab_DS.xlsx'
    df_ds = remove_espacos_e_acentos(path_ds_tab)
    
    path_login_unidades = 'data_bruto/ds_unidades/login_unidades.xlsx'
    df_login_unidades = remove_espacos_e_acentos(path_login_unidades)

    path_login_ds = 'data_bruto/ds_unidades/login_ds.xlsx'
    df_login_ds = remove_espacos_e_acentos(path_login_ds)

    return {
        'unidades': df_unidades, 
        'distritos': df_ds,
        'login_unidades': df_login_unidades,
        'login_ds': df_login_ds
        }

