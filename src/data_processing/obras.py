from ..utils.excel_operations import remove_espacos_e_acentos

def read_obras_data():
    path_obras = 'data_bruto/obras/BASE PLANEJAMENTO SEINFRA REV114 - 26 DE AGOSTO DE 2024.xlsx'

    df_obras = remove_espacos_e_acentos(path_obras, aba_selecionada='BASE INFRA', skip_rows=1)
    return {'obras': df_obras}