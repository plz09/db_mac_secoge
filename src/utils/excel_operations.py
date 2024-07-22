import pandas as pd
import unidecode

def remove_espacos_e_acentos(arquivo, aba_selecionada=None, skip_rows=0, colunas=None, dtype=None):
    """
    Lê uma planilha Excel ou CSV, remove espaços e acentos das colunas da aba selecionada, e retorna o DataFrame resultante.

    :param arquivo: Caminho para o arquivo Excel ou CSV
    :param aba_selecionada: Nome da aba da planilha (opcional). Se não for fornecida, usa a primeira aba.
    :param skip_rows: Número de linhas a serem puladas no início do arquivo (default: 0)
    :param colunas: Lista com os nomes das colunas a serem importadas (opcional)
    :param dtype: Dicionário com os tipos de dados das colunas (opcional)
    :return: DataFrame com os espaços, acentos e caracteres específicos removidos das colunas
    """
    usecols = colunas if colunas else None

    if arquivo.endswith('.xlsx'):
        if aba_selecionada is None:
            df = pd.read_excel(arquivo, skiprows=skip_rows, dtype=dtype, usecols=usecols)
        else:
            df = pd.read_excel(arquivo, sheet_name=aba_selecionada, skiprows=skip_rows, dtype=dtype, usecols=usecols)
    else:
        df = pd.read_csv(arquivo, skiprows=skip_rows, dtype=dtype, usecols=usecols, encoding='utf-8')

    df.columns = [unidecode.unidecode(col).strip().lower().replace(' ', '_').replace('?', '').replace('-', '_').replace('.', '').replace('/', '').replace(':', '').replace('|', '').replace('___', '_') for col in df.columns]
    
    # Converte todas as colunas de string para UTF-8
    for col in df.select_dtypes(include=[object]).columns:
        df[col] = df[col].apply(lambda x: x.encode('utf-8', 'ignore').decode('utf-8') if isinstance(x, str) else x)

    return df
