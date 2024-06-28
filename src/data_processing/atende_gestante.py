import pandas as pd
from ..utils.excel_operations import remove_espacos_e_acentos

def read_atende_gestante_data():
    path_atende_gestante_registro_teleatendimentos = 'data_bruto/Atende_Gestante/registros_teleatendimento.xlsx'
    path_avaliacao_diaria = 'data_bruto/Atende_Gestante/avaliacao_diaria.xlsx'
    
    path_atende_gestante_conectazap = 'data_bruto/Atende_Gestante/CONECTAZAP - SAUDE - RELATÓRIOS CONECTAZAP.xlsx'
    aba_atende_gestante = 'ATENDE GESTANTE'

    #df_atende_gestante_registro_teleatendimentos = pd.read_csv(path_atende_gestante_registro_teleatendimentos, dtype={'DUM': 'str'})
    df_atende_gestante_registro_teleatendimentos = remove_espacos_e_acentos(path_atende_gestante_registro_teleatendimentos)
    df_avaliacao_diaria = remove_espacos_e_acentos(path_avaliacao_diaria)
    df_atende_gestante_conectazap = remove_espacos_e_acentos(path_atende_gestante_conectazap, aba_selecionada=aba_atende_gestante)

    return {
        'registros_teleatendimentos': df_atende_gestante_registro_teleatendimentos,
        'avaliacao_diaria': df_avaliacao_diaria,
        'conectazap': df_atende_gestante_conectazap
    }

