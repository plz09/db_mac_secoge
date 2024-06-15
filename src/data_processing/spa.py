from ..database.database import write_df_to_sql
from ..utils.excel_operations import remove_espacos_e_acentos

def process_spa_files(engine):
    path_matriz_GAH = 'data_bruto/SAP/MatrizGAH_GGAI_SECOGE.xlsx'
    schema = 'spa'  # Defina o esquema onde as tabelas serão criadas
    abas_spa = [
        'SPA - Clínico',
        'SPA - Pediatria',
        'SPA - Ortopedia',
        'SPA - Cirurgia',
        'SPA - Isolamento Pediatria',
        'SPA - Classificação Pediatria',
        'SPA - Classificação',
        'SPA - Odontologia'
    ]
    for aba in abas_spa:
        try:
            df_spa_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba)
        except Exception as e:
            print(f"Erro ao processar a aba {aba}: {e}")
            continue  # pula para a próxima iteração se ocorrer um erro

        table_name = aba.upper().replace(' ', '').replace('  ', '').replace('-', '')
        write_df_to_sql(df_spa_tratado, table_name, engine, schema)
