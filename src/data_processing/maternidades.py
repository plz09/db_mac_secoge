from ..database import write_df_to_sql
from ..utils.excel_operations import remove_espacos_e_acentos

def process_maternidades_files(engine):
    path_matriz_GAH = 'data_bruto/mat_spa/MatrizGAH_GGAI_SECOGE.xlsx'
    schema = 'maternidades'

    abas_maternidades = [
        'Mat. Classificação',
        'Mat. Triagem',
        'Mat. Procedi. Atend.',
        'Mat. Leitos',
        'Municípios de Origem'
    ]

    for aba in abas_maternidades:
        try:
            df_mat_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba)
        except Exception as e:
            print(f"Erro ao processar aba {aba}: {e}")
            continue # pula para a próxima iteração caso ocorra algum erro

        table_name = aba.lower().replace(' ', '').replace('  ', '').replace('-', '').replace('ã', 'a').replace('d.','d').replace('ç','c').replace('í', 'i').replace('.', '_')
        write_df_to_sql(df_mat_tratado, table_name, engine, schema)
   
