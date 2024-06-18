from ..utils.excel_operations import remove_espacos_e_acentos

def read_producao_data():
    path_dFormaOrganiz = 'data_bruto/producao/dFormaOrganiz.xlsx'
    path_fProfissionais = 'data_bruto/producao/fProfissionais.xlsx'
    path_dCBO = 'data_bruto/producao/dCBO.xlsx'
    path_dPort157 = 'data_bruto/producao/dPort157.xlsx'

    df_dFormaOrganiz = remove_espacos_e_acentos(path_dFormaOrganiz)
    df_fProfissionais = remove_espacos_e_acentos(path_fProfissionais)
    df_dCBO = remove_espacos_e_acentos(path_dCBO)
    df_dPort157 = remove_espacos_e_acentos(path_dPort157)

    return {
        'dformafrganiz': df_dFormaOrganiz,
        'fprofissionais': df_fProfissionais,
        'dcbo': df_dCBO,
        'dport157': df_dPort157,
    }
