from ..utils.excel_operations import remove_espacos_e_acentos

def read_producao_data():
    path_dFormaOrganiz = 'data_bruto/producao/dFormaOrganiz.xlsx'
    path_fProfissionais = 'data_bruto/producao/fProfissionais.xlsx'
    path_dCBO = 'data_bruto/producao/dCBO.xlsx'
    path_dPort157 = 'data_bruto/producao/dPort157.xlsx'
    path_fproducao = 'data_bruto/producao/PAPE2405.csv'
    path_dextrato_profissionais_sus = 'data_bruto/producao/dExtrato_Profissioais_SUS.xlsx'

    df_dFormaOrganiz = remove_espacos_e_acentos(path_dFormaOrganiz)
    df_fProfissionais = remove_espacos_e_acentos(path_fProfissionais)
    df_dCBO = remove_espacos_e_acentos(path_dCBO)
    df_dPort157 = remove_espacos_e_acentos(path_dPort157)

    cols_fproducao = ['PA_CODUNI', 'PA_CMP', 'PA_CNSMED', 'PA_CBOCOD', 'PA_PROC_ID', 'PA_QTDAPR']
    df_fproducao = remove_espacos_e_acentos(path_fproducao, colunas=cols_fproducao, dtype={'PA_CBOCOD': str})

    df_dextrato_profissionais_sus = remove_espacos_e_acentos(path_dextrato_profissionais_sus)

    return {
        'dformaorganiz': df_dFormaOrganiz,
        'fprofissionais': df_fProfissionais,
        'dcbo': df_dCBO,
        'dport157': df_dPort157,
        'fproducao2024': df_fproducao,
        'dextrato_profissionais_sus': df_dextrato_profissionais_sus
    }
