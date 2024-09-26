import os
import sys
import pandas as pd
from datetime import datetime

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos

def clean_date_columns(df, date_columns):
    """
    Limpa e converte colunas de data em um DataFrame para garantir que apenas datas válidas sejam mantidas.
    """
    for col in date_columns:
        # Converte coluna para datetime, erros='coerce' transforma valores inválidos em NaT
        df[col] = pd.to_datetime(df[col], errors='coerce', format='%Y-%m-%d %H:%M:%S')
        # Remove linhas com NaT (datas inválidas)
        df = df.dropna(subset=[col])
    return df

def read_atende_gestante_data():
    path_atende_gestante_registro_teleatendimentos = '/Shared Documents/SESAU/NGI/data_bruto_mac/atende_gestante/Atende Gestante - Registro de Atendimentos.xlsx'
    aba_registro_teleatendimento = 'Registro de teleatendimento'
    path_avaliacao_diaria = '/Shared Documents/SESAU/NGI/data_bruto_mac/atende_gestante/avaliacao_diaria.xlsx'
    
    path_atende_gestante_conectazap = '/Shared Documents/SESAU/NGI/data_bruto_mac/atende_gestante/CONECTAZAP - SAUDE - RELATÓRIOS CONECTAZAP.xlsx'
    aba_conecta_zap = 'ATENDE GESTANTE'

    df_atende_gestante_registro_teleatendimentos = get_file_as_dataframes(path_atende_gestante_registro_teleatendimentos, sheet_name=aba_registro_teleatendimento)
    df_atende_gestante_registro_teleatendimentos_columns = ['Carimbo de data/hora', 'Neste momento, foi necessário converter para o atendimento presencial?',
                                                            'Foi necessário encaminhamento para outro serviço?']
    df_atende_gestante_registro_teleatendimentos = df_atende_gestante_registro_teleatendimentos[df_atende_gestante_registro_teleatendimentos_columns]
    df_atende_gestante_registro_teleatendimentos = remove_espacos_e_acentos(df_atende_gestante_registro_teleatendimentos)
    df_atende_gestante_registro_teleatendimentos = clean_date_columns(df_atende_gestante_registro_teleatendimentos, ['carimbo_de_datahora'])

    df_avaliacao_diaria = get_file_as_dataframes(path_avaliacao_diaria)
    df_avaliacao_diaria = remove_espacos_e_acentos(df_avaliacao_diaria)
    df_avaliacao_diaria = clean_date_columns(df_avaliacao_diaria, ['data'])  # Adicione a coluna 'data' se estiver presente no DataFrame

    df_atende_gestante_conectazap = get_file_as_dataframes(path_atende_gestante_conectazap, sheet_name=aba_conecta_zap)
    df_atende_gestante_conectazap = remove_espacos_e_acentos(df_atende_gestante_conectazap)
    df_atende_gestante_conectazap = clean_date_columns(df_atende_gestante_conectazap, ['data'])  # Supondo que a coluna 'data' está presente

    return {
        'registros_teleatendimentos': df_atende_gestante_registro_teleatendimentos,
        'avaliacao_diaria': df_avaliacao_diaria,
        'conectazap': df_atende_gestante_conectazap
    }
