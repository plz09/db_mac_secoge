from ..database.database import write_df_to_sql
from ..utils.excel_operations import remove_espacos_e_acentos

def process_mae_coruja_data(engine):
    # Leitura dos dados
    path_mae_coruja_mulher = 'data_bruto/Mae_Coruja/DADOS MULHER.xlsx'
    path_mae_coruja_crianca = 'data_bruto/Mae_Coruja/DADOS CRIANÇA.xlsx'
    path_mae_coruja_kits = 'data_bruto/Mae_Coruja/consolidado_kits_pmcr.xlsx'
    aba_2024_mae_coruja_kits = '2024'

    df_mae_coruja_mulher = remove_espacos_e_acentos(path_mae_coruja_mulher)
    df_mae_coruja_crianca = remove_espacos_e_acentos(path_mae_coruja_crianca)
    df_mae_coruja_kits = remove_espacos_e_acentos(path_mae_coruja_kits, aba_selecionada=aba_2024_mae_coruja_kits)

    data = {
        'mae_coruja_mulher': df_mae_coruja_mulher,
        'mae_coruja_crianca': df_mae_coruja_crianca,
        'mae_coruja_kits_aba_2024': df_mae_coruja_kits
    }

    schema = 'mae_coruja'
    for table_name, df in data.items():
        print(f"Escrevendo a tabela {table_name} no esquema {schema}.")
        write_df_to_sql(df, table_name, engine, schema)

    # Processamento adicional dos arquivos específicos
    path_mae_coruja_espacos = 'data_bruto/Mae_Coruja/Listagem_Espacos_PMCR_endereco_bairros_cobertos.xlsx'
    abas_mae_coruja_espacos = [
        'ESPACOS',
        'Espaços_Unidades',
        'Espaços_Bairros_Cobertos'
    ]

    for aba in abas_mae_coruja_espacos:
        if aba == 'ESPACOS':
            colunas_definidas = ['ESPAÇO', 'DS', 'SIGLA', 'LOCAL', 'ENDEREÇO', 'BAIRROS COBERTOS',
                                 'UNIDADES COBERTAS', 'DATA INAUGURAÇÃO ESPAÇO PMCR']
            try:
                df_mae_coruja_espacos = remove_espacos_e_acentos(
                    path_mae_coruja_espacos, aba_selecionada=aba, skip_rows=5, colunas=colunas_definidas)
            except Exception as e:
                print(f"Erro ao processar a aba {aba}: {e}")
                continue  # pula para a próxima iteração se ocorrer um erro
        else:
            try:
                df_mae_coruja_espacos = remove_espacos_e_acentos(
                    path_mae_coruja_espacos, aba_selecionada=aba)
            except Exception as e:
                print(f"Erro ao processar a aba {aba}: {e}")
                continue  # pula para a próxima iteração se ocorrer um erro

        table_name = aba.lower().replace(' ', '').replace('  ', '').replace('-', '').replace('ç', 'c')
        write_df_to_sql(df_mae_coruja_espacos, table_name, engine, schema)
