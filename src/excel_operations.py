import pandas as pd
import unidecode

def remove_espacos_e_acentos(arquivo, aba_selecionada=None, skip_rows=0, colunas=None):
    """
    Lê uma planilha Excel, remove espaços e acentos das colunas da aba selecionada, e retorna o DataFrame resultante.

    :param arquivo: Caminho para o arquivo Excel ou CSV
    :param aba_selecionada: Nome da aba da planilha (opcional). Se não for fornecida, usa a primeira aba.
    :param skip_rows: Número de linhas a serem puladas no início do arquivo (default: 0)
    :param colunas: Lista com os nomes das colunas a serem definidas (opcional)
    :return: DataFrame com os espaços, acentos e caracteres específicos removidos das colunas
    """

    if arquivo.endswith('.xlsx'):
        if aba_selecionada is None:
            df = pd.read_excel(arquivo, skiprows=skip_rows)
        else:
            df = pd.read_excel(arquivo, sheet_name=aba_selecionada, skiprows=skip_rows)
    else:
        df = pd.read_csv(arquivo, skiprows=skip_rows)
    
    if colunas is not None:
        if isinstance(colunas, list):
            df.columns = [unidecode.unidecode(col).replace(' ', '_').replace('?', '').replace('-', '_').replace('.', '') for col in colunas]
        else:
            df.columns = unidecode.unidecode(colunas).replace(' ', '_').replace('?', '').replace('-', '_').replace('.', '')
    else:
        # Remove espaços e acentos dos nomes das colunas
        df.columns = [unidecode.unidecode(col).replace(' ', '_').replace('?', '').replace('-', '_').replace('.', '') for col in df.columns]

    return df
