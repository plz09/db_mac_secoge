import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos

def read_horus_data():
    path_horus_dispensa_medicamentos = '/Shared Documents/SESAU/NGI/data_bruto_mac/horus/Dispensação_Medicamentos_Saude_Mulher_-_CAF_para_Unidades.xlsx'
    path_horus_historico_pacientes = '/Shared Documents/SESAU/NGI/data_bruto_mac/horus/planilhaHistoricoPacientes.xlsx'
    path_horus_ref_anticoncep = '/Shared Documents/SESAU/NGI/data_bruto_mac/horus/ref_anticoncep.xlsx'

    df_horus_dispensa_medicamentos = get_file_as_dataframes(path_horus_dispensa_medicamentos)
    df_horus_dispensa_medicamentos = remove_espacos_e_acentos(df_horus_dispensa_medicamentos)

    df_horus_historico_pacientes = get_file_as_dataframes(path_horus_historico_pacientes)
    df_horus_historico_pacientes = remove_espacos_e_acentos(df_horus_historico_pacientes)

    df_horus_ref_anticoncep = get_file_as_dataframes(path_horus_ref_anticoncep)
    df_horus_ref_anticoncep = remove_espacos_e_acentos(df_horus_ref_anticoncep)

    return {
        'dispensa_medicamentos': df_horus_dispensa_medicamentos,
        'historico_pacientes': df_horus_historico_pacientes,
        'ref_anticoncep' : df_horus_ref_anticoncep
    }
