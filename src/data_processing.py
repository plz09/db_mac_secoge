import pandas as pd
from .excel_operations import remove_espacos_e_acentos

def read_data_files():
    # Caminho dos arquivos de produção
    path_rede_saude_geo = 'data_bruto/producao/REDE_SAUDE_RECIFE_GEO.xlsx'
    #path_fProducao2024 = 'data_bruto/producao/fProducao2024.csv'
    path_dFormaOrganiz = 'data_bruto/producao/dFormaOrganiz.xlsx'
    path_fProfissionais = 'data_bruto/producao/fProfissionais.xlsx'
    path_dCBO = 'data_bruto/producao/dCBO.xlsx'
    path_dPort157 = 'data_bruto/producao/dPort157.xlsx'

    # Caminho dos arquivos de ouvidoria
    path_ouvidoria = 'data_bruto/ouvidoria/Banco_de_Dados_Ouvidoria_do_SUS_Recife _2019_ate _o_dia_03_06_2024.xlsx'

    # Caminho dos arquivos de horus
    path_horus_dispensao_medicamentos = 'data_bruto/horus/Dispensação_Medicamentos_Saude_Mulher_-_CAF_para_Unidades.xlsx'
    path_horus_historico_pacientes = 'data_bruto/horus/planilhaHistoricoPacientes.xlsx'

    # Caminho dos arquivos de Mãe Coruja
    path_mae_coruja_mulher = 'data_bruto/Mae_Coruja/DADOS MULHER.xlsx'
    path_mae_coruja_crianca = 'data_bruto/Mae_Coruja/DADOS CRIANÇA.xlsx'
    path_mae_coruja_kits = 'data_bruto/Mae_Coruja/consolidado_kits_pmcr.xlsx'
    aba_2024_mae_coruja_kits = '2024'

    # Caminho dos arquivos Atende_Gestante
    path_atende_gestante_registro_teleatendimentos = 'data_bruto/Atende_Gestante/Atende_Gestante_Registro_Teleatendimento.csv'
    path_atende_gestante_conectazap = 'data_bruto/Atende_Gestante/CONECTAZAP - SAUDE - RELATÓRIOS CONECTAZAP.xlsx'
    aba_atende_gestante = 'ATENDE GESTANTE'

    # Leitura arquivos ATBasica
    path_ATBasica_puericultura = 'data_bruto/ATBasica/Consulta Puericultura 2023 a 2024_31_05.xlsx'
    path_ATBasica_puerperal = 'data_bruto/ATBasica/Consulta Puerperal 2023 a 2024_31_05.xlsx'
    path_ATBasica_ifo_gestantes = 'data_bruto/ATBasica/Informações Gestantes 2024_31_05.xlsx'
    aba_info_gestate_planilha_calculo = 'Planilha Calculo'
    path_ATBasica_qttativos_gestantes_acompanhadas = 'data_bruto/ATBasica/Quantitativo de Gestantes Acompanhadas.xlsx'

    # Leitura dos arquivos Excel e CSV
    df_unidades = remove_espacos_e_acentos(path_rede_saude_geo, aba_selecionada='UNIDADES')
    #df_fproducao2024 = pd.read_csv(path_fProducao2024, dtype={'CBO': 'str'})
    df_dFormaOrganiz = remove_espacos_e_acentos(path_dFormaOrganiz)
    df_fProfissionais = remove_espacos_e_acentos(path_fProfissionais)
    df_dCBO = remove_espacos_e_acentos(path_dCBO)
    df_dPort157 = remove_espacos_e_acentos(path_dPort157)
    df_ouvidoria = remove_espacos_e_acentos(path_ouvidoria)
    df_horus_dispensao_medicamentos = remove_espacos_e_acentos(path_horus_dispensao_medicamentos)
    df_horus_historico_pacientes = remove_espacos_e_acentos(path_horus_historico_pacientes)
    df_mae_coruja_mulher = remove_espacos_e_acentos(path_mae_coruja_mulher)
    df_mae_coruja_crianca = remove_espacos_e_acentos(path_mae_coruja_crianca)
    df_mae_coruja_kits = remove_espacos_e_acentos(path_mae_coruja_kits, aba_selecionada=aba_2024_mae_coruja_kits)
    df_atende_gestante_registro_teleatendimentos = pd.read_csv(path_atende_gestante_registro_teleatendimentos, dtype={'DUM': 'str'})
    df_atende_gestante_conectazap = remove_espacos_e_acentos(path_atende_gestante_conectazap, aba_selecionada=aba_atende_gestante)
    df_ATBasica_puericultura = remove_espacos_e_acentos(path_ATBasica_puericultura)
    df_ATBasica_puerperal = remove_espacos_e_acentos(path_ATBasica_puerperal)
    df_ATbasica_info_gestantes = remove_espacos_e_acentos(path_ATBasica_ifo_gestantes, aba_selecionada=aba_info_gestate_planilha_calculo)
    df_qttativos_gestantes_acompanhadas = remove_espacos_e_acentos(path_ATBasica_qttativos_gestantes_acompanhadas)


    return {
        'Unidades': df_unidades,
        #'fProducao2024': df_fproducao2024,
        'dFormaOrganiz': df_dFormaOrganiz,
        'fProfissionais': df_fProfissionais,
        'dCBO': df_dCBO,
        'dPort157': df_dPort157,
        'ouvidoria': df_ouvidoria,
        'horus_dispensao_medicamentos': df_horus_dispensao_medicamentos,
        'horus_historico_pacientes': df_horus_historico_pacientes,
        'mae_coruja_mulher': df_mae_coruja_mulher,
        'mae_coruja_crianca': df_mae_coruja_crianca,
        'mae_coruja_kits_aba_2024': df_mae_coruja_kits,
        'atende_gestante_registros_teleatendimentos': df_atende_gestante_registro_teleatendimentos,
        'atende_gestante_conectazap': df_atende_gestante_conectazap,
        'consulta_puericultura': df_ATBasica_puericultura,
        'consulta_puerpural': df_ATBasica_puerperal,
        'info_gestantes': df_ATbasica_info_gestantes,
        'quantitativo_gestantes_acompanhadas': df_qttativos_gestantes_acompanhadas
    }
