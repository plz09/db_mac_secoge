from ..utils.excel_operations import remove_espacos_e_acentos
import pandas as pd

def read_horus_data():
    path_horus_dispensa_medicamentos = 'data_bruto/horus/Dispensação_Medicamentos_Saude_Mulher_-_CAF_para_Unidades.xlsx'
    path_horus_historico_pacientes = 'data_bruto/horus/planilhaHistoricoPacientes.xlsx'

    df_horus_dispensa_medicamentos = remove_espacos_e_acentos(path_horus_dispensa_medicamentos)
    df_horus_historico_pacientes = remove_espacos_e_acentos(path_horus_historico_pacientes)

    return {
        'horus_dispensa_medicamentos': df_horus_dispensa_medicamentos,
        'horus_historico_pacientes': df_horus_historico_pacientes
    }
