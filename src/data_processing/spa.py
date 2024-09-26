import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos
from src.database.database import write_df_to_sql

def process_spa_files(engine):
    path_matriz_GAH = '/Shared Documents/SESAU/NGI/data_bruto_mac/mat_spa/Matriz GAH_GGAI - SECOGE.xlsx'
    schema = 'spa'  

    abas_spa = [
        'SPA - Clínico',
        'SPA - Pediatria',
        'SPA - Ortopedia',
        'SPA - Cirurgia',
        'SPA - Isolamento Pediatria',
        'SPA - Classificação Pediatria',
        'SPA - Classificação',
        'SPA - Odontologia',
        'SPA - Isolamento'
    ]
    
    for aba in abas_spa:
            try:
                df_spa = get_file_as_dataframes(path_matriz_GAH, sheet_name=aba)
                if df_spa is not None:
                    df_spa_tratado = remove_espacos_e_acentos(df_spa)
                else:
                    print(f"DataFrame não carregado para a aba {aba}")
                    continue
            except Exception as e:
                print(f"Erro ao processar a aba {aba}: {e}")
                continue  # Pula para a próxima iteração se ocorrer um erro

            # Simplifica e padroniza o nome da tabela
            table_name = aba.lower().replace(' ', '').replace('-', '').replace('ç', 'c').replace('ã', 'a').replace('í', 'i').replace('spa', 'spa_')
            write_df_to_sql(df_spa_tratado, table_name, engine, schema)
