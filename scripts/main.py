# main.py

import sys
import os

# Adiciona o diretório raiz do projeto ao sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import connect_to_db, write_data_to_database
from src.data_processing import read_data_files
from src.spa_processing import process_spa_files
from src.unidades_mac import create_and_populate_unidades_mac  # Nova importação
from src.mae_coruja_processing import process_mae_coruja_files

def main():
    # Leitura dos arquivos e preparação dos dataframes
    dataframes = read_data_files()

    # Conexão com o banco de dados SQLite
    with connect_to_db() as con:
        # Escreve os dataframes no banco de dados
        write_data_to_database(dataframes, con)

        # Cria e popula a tabela Unidades_mac
        create_and_populate_unidades_mac(con)

        # Processa os arquivos SPA
        process_spa_files(con)

        # Processa os arquivos mae_coruja_espacos
        process_mae_coruja_files(con)

if __name__ == '__main__':
    main()
