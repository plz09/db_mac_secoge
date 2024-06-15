# spa_processing.py

from .database import write_df_to_sql
from .excel_operations import remove_espacos_e_acentos

def process_spa_files(con):
    path_matriz_GAH = 'data_bruto/SAP/MatrizGAH_GGAI_SECOGE.xlsx'
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
        df_spa_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba)
        table_name = aba.upper().replace(' ', '').replace('  ', '').replace('-', '')
        write_df_to_sql(df_spa_tratado, table_name, con)
