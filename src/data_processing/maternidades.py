import os
import sys
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(root_dir)

from src.utils.extract_sharepoint import get_file_as_dataframes
from src.utils.excel_operations import remove_espacos_e_acentos
from src.database.database import write_df_to_sql

def process_maternidades_files(engine):
    path_matriz_GAH = '/Shared Documents/SESAU/NGI/data_bruto_mac/mat_spa/Matriz GAH_GGAI - SECOGE.xlsx'
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
            df = get_file_as_dataframes(path_matriz_GAH, sheet_name=aba)
            if df is None:
                print(f"Nenhum dado carregado para a aba {aba}")
                continue
            df_tratado = remove_espacos_e_acentos(df)
        except Exception as e:
            print(f"Erro ao processar aba {aba}: {e}")
            continue  # Pula para a próxima iteração se ocorrer um erro

        table_name = aba.lower().replace(' ', '').replace('  ', '').replace('-', '').replace('ã', 'a').replace('d.', 'd').replace('ç', 'c').replace('í', 'i').replace('.', '_')
        write_df_to_sql(df_tratado, table_name, engine, schema)
