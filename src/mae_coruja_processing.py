from .database import write_df_to_sql
from .excel_operations import remove_espacos_e_acentos

def process_mae_coruja_files(engine):
    path_mae_coruja_espacos = 'data_bruto/Mae_Coruja/Listagem_Espacos_PMCR_endereco_bairros_cobertos.xlsx'
    schema = 'mae_coruja'

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
                    path_mae_coruja_espacos, aba_selecionada=aba, skip_rows=3, colunas=colunas_definidas)
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

        table_name = aba.upper().replace(' ', '').replace('  ', '').replace('-', '').replace('Ç', 'C')
        write_df_to_sql(df_mae_coruja_espacos, table_name, engine, schema)
