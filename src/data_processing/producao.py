from ..utils.excel_operations import remove_espacos_e_acentos

def read_producao_data():
    path_dFormaOrganiz = 'data_bruto/producao/dFormaOrganiz.xlsx'
    path_fProfissionais = 'data_bruto/producao/fProfissionais.xlsx'
    path_dCBO = 'data_bruto/producao/dCBO.xlsx'
    path_dPort157 = 'data_bruto/producao/dPort157.xlsx'
    path_fproducao2024 = 'data_bruto/producao/fProducao2024.csv'

    df_dFormaOrganiz = remove_espacos_e_acentos(path_dFormaOrganiz)
    df_fProfissionais = remove_espacos_e_acentos(path_fProfissionais)
    df_dCBO = remove_espacos_e_acentos(path_dCBO)
    df_dPort157 = remove_espacos_e_acentos(path_dPort157)
    df_fproducao2024 = remove_espacos_e_acentos(path_fproducao2024, dtype={3: str})

    return {
        'dformaorganiz': df_dFormaOrganiz,
        'fprofissionais': df_fProfissionais,
        'dcbo': df_dCBO,
        'dport157': df_dPort157,
        'fproducao2024': df_fproducao2024
    }
