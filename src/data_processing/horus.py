from ..utils.excel_operations import remove_espacos_e_acentos
import pandas as pd

def read_horus_data():
    path_horus_dispensa_medicamentos = 'data_bruto/horus/Dispensação_Medicamentos_Saude_Mulher_-_CAF_para_Unidades.xlsx'
    path_horus_historico_pacientes = 'data_bruto/horus/planilhaHistoricoPacientes.xlsx'
    path_horus_ref_anticoncep = 'data_bruto/horus/ref_anticoncep.xlsx'

    df_horus_dispensa_medicamentos = remove_espacos_e_acentos(path_horus_dispensa_medicamentos)
    df_horus_historico_pacientes = remove_espacos_e_acentos(path_horus_historico_pacientes)
    df_horus_ref_anticoncep = remove_espacos_e_acentos(path_horus_ref_anticoncep)

    return {
        'dispensa_medicamentos': df_horus_dispensa_medicamentos,
        'historico_pacientes': df_horus_historico_pacientes,
        'ref_anticoncep' : df_horus_ref_anticoncep
    }
