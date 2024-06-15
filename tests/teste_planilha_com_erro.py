import os
from openpyxl import load_workbook

# Função para processar recursivamente os arquivos Excel em um diretório
def processar_planilhas(diretorio):
    for root, dirs, files in os.walk(diretorio):
        for nome_arquivo in files:
            if nome_arquivo.endswith('.xlsx'):
                caminho_arquivo = os.path.join(root, nome_arquivo)
                print(f'Processando planilha: {caminho_arquivo}')
                try:
                    workbook = load_workbook(caminho_arquivo)
                    # Aqui você pode adicionar lógica para processar cada planilha
                except Exception as e:
                    print(f'Erro ao processar planilha {caminho_arquivo}: {str(e)}')

# Diretório onde estão as planilhas (diretório raiz que contém várias pastas)
diretorio_raiz = 'C:\\Users\\pellizzi\\Documents\\sec_saude\\db_mac_secoge\\data_bruto'


# Chama a função para processar todas as planilhas no diretório raiz e subpastas
processar_planilhas(diretorio_raiz)


# Erros JÁ RESOLVIDO COM TIPO DE DADO STR NA COLUNA DUM em: tende_Gestante\Atende_Gestante_Registro_Teleatendimento.xlsx

# Processando planilha: C:\Users\pellizzi\Documents\sec_saude\db_mac_secoge\data_bruto\Atende_Gestante\Atende_Gestante_Registro_Teleatendimento.xlsx
# C:\Users\pellizzi\Documents\sec_saude\db_mac_secoge\.venv\Lib\site-packages\openpyxl\worksheet\_reader.py:223: UserWarning: Cell J955 is marked as a date but the serial value 6692411.0 is outside the limits for dates. The cell will be treated as an error.
#   warn(msg)
# C:\Users\pellizzi\Documents\sec_saude\db_mac_secoge\.venv\Lib\site-packages\openpyxl\worksheet\_reader.py:223: UserWarning: Cell J1447 is marked as a date but the serial value 7349774.0 is outside the limits for dates. The cell will be treated as an error.
#   warn(msg)

# Warnings em: Banco_de_Dados_Ouvidoria_do_SUS_Recife _2019_ate _o_dia_03_06_2024.xlsx

# Processando planilha: C:\Users\pellizzi\Documents\sec_saude\db_mac_secoge\data_bruto\ouvidoria\Banco_de_Dados_Ouvidoria_do_SUS_Recife _2019_ate _o_dia_03_06_2024.xlsx
# C:\Users\pellizzi\Documents\sec_saude\db_mac_secoge\.venv\Lib\site-packages\openpyxl\worksheet\_reader.py:329: UserWarning: Unknown extension is not supported and will be removed
#   warn(msg)