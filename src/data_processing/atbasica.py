from ..utils.excel_operations import remove_espacos_e_acentos

def read_atbasica_data():
    path_ATBasica_puericultura = 'data_bruto/ATBasica/Consulta Puericultura 2023 a 2024_31_05.xlsx'
    path_ATBasica_puerperal = 'data_bruto/ATBasica/Consulta Puerperal 2023 a 2024_31_05.xlsx'
    path_ATBasica_ifo_gestantes = 'data_bruto/ATBasica/Informações Gestantes 2024_31_05.xlsx'
    aba_info_gestate_planilha_calculo = 'Planilha Calculo'
    path_ATBasica_qttativos_gestantes_acompanhadas = 'data_bruto/ATBasica/Quantitativo de Gestantes Acompanhadas.xlsx'

    df_ATBasica_puericultura = remove_espacos_e_acentos(path_ATBasica_puericultura)
    df_ATBasica_puerperal = remove_espacos_e_acentos(path_ATBasica_puerperal)
    df_ATbasica_info_gestantes = remove_espacos_e_acentos(path_ATBasica_ifo_gestantes, aba_selecionada=aba_info_gestate_planilha_calculo)
    df_qttativos_gestantes_acompanhadas = remove_espacos_e_acentos(path_ATBasica_qttativos_gestantes_acompanhadas)

    return {
        'consulta_puericultura': df_ATBasica_puericultura,
        'consulta_puerpural': df_ATBasica_puerperal,
        'info_gestantes': df_ATbasica_info_gestantes,
        'quantitativo_gestantes_acompanhadas': df_qttativos_gestantes_acompanhadas
    }
