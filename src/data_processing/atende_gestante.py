import pandas as pd
from ..utils.excel_operations import remove_espacos_e_acentos

def read_atende_gestante_data():
    path_atende_gestante_registro_teleatendimentos = 'data_bruto/Atende_Gestante/Atende_Gestante_Registro_Teleatendimento.csv'
    path_atende_gestante_conectazap = 'data_bruto/Atende_Gestante/CONECTAZAP - SAUDE - RELATÓRIOS CONECTAZAP.xlsx'
    aba_atende_gestante = 'ATENDE GESTANTE'

    df_atende_gestante_registro_teleatendimentos = pd.read_csv(path_atende_gestante_registro_teleatendimentos, dtype={'DUM': 'str'})
    df_atende_gestante_conectazap = remove_espacos_e_acentos(path_atende_gestante_conectazap, aba_selecionada=aba_atende_gestante)

    return {
        'atende_gestante_registros_teleatendimentos': df_atende_gestante_registro_teleatendimentos,
        'atende_gestante_conectazap': df_atende_gestante_conectazap
    }
