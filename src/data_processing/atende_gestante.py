import pandas as pd
from ..utils.excel_operations import remove_espacos_e_acentos

def read_atende_gestante_data():
    path_atende_gestante_registro_teleatendimentos = 'data_bruto/atende_gestante/Atende Gestante - Registro de Atendimentos.xlsx'
    aba_registro_teleatendimento = 'Registro de teleatendimento'
    path_avaliacao_diaria = 'data_bruto/atende_gestante/avaliacao_diaria.xlsx'
    
    path_atende_gestante_conectazap = 'data_bruto/atende_gestante/CONECTAZAP - SAUDE - RELATÓRIOS CONECTAZAP.xlsx'
    aba_atende_gestante = 'ATENDE GESTANTE'

    #df_atende_gestante_registro_teleatendimentos = pd.read_csv(path_atende_gestante_registro_teleatendimentos, dtype={'DUM': 'str'})
    df_atende_gestante_registro_teleatendimentos = remove_espacos_e_acentos(path_atende_gestante_registro_teleatendimentos, aba_selecionada=aba_registro_teleatendimento)
    df_avaliacao_diaria = remove_espacos_e_acentos(path_avaliacao_diaria)
    df_atende_gestante_conectazap = remove_espacos_e_acentos(path_atende_gestante_conectazap, aba_selecionada=aba_atende_gestante)

    return {
        'registros_teleatendimentos': df_atende_gestante_registro_teleatendimentos,
        'avaliacao_diaria': df_avaliacao_diaria,
        'conectazap': df_atende_gestante_conectazap
    }

