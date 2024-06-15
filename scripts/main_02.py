import pandas as pd
import sqlite3
import unidecode

def remove_espacos_e_acentos(arquivo_excel, aba_selecionada=None):
    """
    Lê uma planilha Excel, remove espaços e acentos das colunas da aba selecionada, e retorna o DataFrame resultante.

    :param arquivo_excel: Caminho para o arquivo Excel
    :param aba_selecionada: Nome da aba da planilha (opcional). Se não for fornecida, usa a primeira aba.
    :return: DataFrame com os espaços, acentos e caracteres específicos removidos das colunas
    """

    # Lê a planilha Excel
    if aba_selecionada is None:
        # Carrega a primeira aba se aba_selecionada não for fornecida
        df = pd.read_excel(arquivo_excel)
    else:
        # Carrega a aba especificada
        df = pd.read_excel(arquivo_excel, sheet_name=aba_selecionada)

    # Remove espaços e acentos dos nomes das colunas
    df.columns = [unidecode.unidecode(col).replace(' ', '_').replace('?', '').replace('-', '_').replace('.', '') for col in df.columns]

    return df

# Caminho dos arquivos de producao
path_rede_saude_geo = 'data_bruto/producao/REDE_SAUDE_RECIFE_GEO.xlsx'
arquivo_rede_saude_geo = pd.read_excel(path_rede_saude_geo)
aba_unidades = 'UNIDADES'
data_unidades = pd.read_excel(path_rede_saude_geo, sheet_name=aba_unidades)


data_unidades.rename(columns={
    'CNES PADRÃO': 'CNES_PADRAO',
    'Nº DA US': 'CODIGO_UNIDADE',
    'DS': 'DISTRITO',
    'UNIDADE DE SAÚDE': 'NOME',
    'TIPO_SERVI' : 'TIPO_SERVI',
}, inplace=True)

path_fProducao2024 = 'data_bruto/producao/fProducao2024.csv'
data_fproducao2024 = pd.read_csv(path_fProducao2024, dtype={'CBO': 'str'})
col_fproducao2024 = data_fproducao2024.columns.tolist()

path_dFormaOrganiz = 'data_bruto/producao/dFormaOrganiz.xlsx'
data_dFormaOrganiz = pd.read_excel(path_dFormaOrganiz)

path_fProfissionais = 'data_bruto/producao/fProfissionais.xlsx'
data_fProfissionais = pd.read_excel(path_fProfissionais)

path_dCBO = 'data_bruto/producao/dCBO.xlsx'
data_dCBO = pd.read_excel(path_dCBO)

path_dPort157 = 'data_bruto/producao/dPort157.xlsx'
data_dPort157 = pd.read_excel(path_dPort157)

# Conectar ao banco de dados SQLite
con = sqlite3.connect('db_mac.sqlite')
dtype = {'CBO': 'TEXT'}

# Escrever os DataFrames de Produção no banco de dados SQLite
data_unidades.to_sql('Unidades', con, if_exists='replace', index=False)
data_fproducao2024.to_sql('fProducao2024', con, if_exists='replace', index=False, dtype=dtype)
data_dFormaOrganiz.to_sql('dFormaOrganiz', con, if_exists='replace', index=False)
data_fProfissionais.to_sql('fProfissionais', con, if_exists='replace', index=False)
data_dCBO.to_sql('dCBO', con, if_exists='replace', index=False)
data_dPort157.to_sql('dPort157', con, if_exists='replace', index=False)

# Criar a tabela Unidades_tratado
con.execute('''
    CREATE TABLE IF NOT EXISTS Unidades_tratado (
        CNES_PADRAO INTEGER,
        CODIGO_UNIDADE INTEGER,
        DISTRITO INTEGER,
        NOME TEXT,
        TIPO_SERVI TEXT
    );
''')

# Limpando a tabela antes de inserir os dados
con.execute('DELETE FROM Unidades_tratado;')

# Populando a tabela Unidades_tratado com dados da tabela Unidades
con.execute('''
    INSERT INTO Unidades_tratado (CNES_PADRAO, CODIGO_UNIDADE, DISTRITO, NOME, TIPO_SERVI)
    SELECT CNES_PADRAO, CODIGO_UNIDADE, DISTRITO, NOME, TIPO_SERVI
    FROM Unidades;
''')

# Selecionar dados da tabela Unidades_tratado
result_df = pd.read_sql_query('''
    SELECT *
    FROM Unidades_tratado;
''', con)

#print(result_df)

# Exportar planilha unidades tratado
#output_path = 'data/Unidades_tratado.xlsx'
#result_df.to_excel(output_path, index=False)
#print(f"Dados exportados para {output_path}")

# Fechar a conexão com o banco de dados
con.close()

# Caminho dos arquivos de SPA
path_tab_DS = 'data_bruto/SAP/tab_DS.xlsx'
data_tab_DS = pd.read_excel(path_tab_DS)

path_ofertas_por_unidades = 'data_bruto/SAP/ofertas_por_unidade.csv'
df_ofertas_por_unidade = pd.read_csv(path_ofertas_por_unidades)

path_matriz_GAH = 'data_bruto/SAP/MatrizGAH_GGAI_SECOGE.xlsx'
arquivo_matriz_GAH = pd.read_excel(path_matriz_GAH)
aba_spa_clinico = 'SPA - Clínico'
df_spa_clinico_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_spa_clinico)

aba_spa_pediatria = 'SPA - Pediatria'
df_spa_pediatria_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_spa_pediatria)

aba_spa_ortopedia = 'SPA - Ortopedia'
df_spa_ortopedia_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_spa_ortopedia)

aba_cirurgia = 'SPA - Cirurgia'
df_spa_cirurgia_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_cirurgia)

aba_spa_isolamento_pediatrico = 'SPA - Isolamento Pediatria'
df_spa_isolamento_pediatrico_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_spa_isolamento_pediatrico)

aba_spa_classificacao_pediatrica = 'SPA - Classificação Pediatria'
df_spa_classificacao_pediatrica_tratado = remove_espacos_e_acentos(path_matriz_GAH,aba_spa_classificacao_pediatrica)

aba_spa_classificao = 'SPA - Classificação'
df_spa_classificacao_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_spa_classificao)

aba_spa_odontologia = 'SPA - Odontologia'
df_spa_odontologia_tratado = remove_espacos_e_acentos(path_matriz_GAH, aba_spa_odontologia)

# Abrir conexão com o banco de dados
con = sqlite3.connect('db_mac.sqlite')

# Escrever os DataFrames de SAP no banco de dados SQLite
data_tab_DS.to_sql('tab_DS', con, if_exists='replace', index=False)
df_ofertas_por_unidade.to_sql('ofertas_por_unidade', con, if_exists='replace', index=False)
df_spa_clinico_tratado.to_sql('spa_clinico', con, if_exists='replace', index=False)
df_spa_pediatria_tratado.to_sql('spa_pediatria', con, if_exists='replace', index=False)
df_spa_ortopedia_tratado.to_sql('spa_ortopedia', con, if_exists='replace', index=False)
df_spa_cirurgia_tratado.to_sql('spa_cirurgia', con, if_exists='replace', index=False)
df_spa_isolamento_pediatrico_tratado.to_sql('spa_isolamento_pediatrico', con, if_exists='replace', index=False)
df_spa_classificacao_pediatrica_tratado.to_sql('spa_classificacao_pediatrica', con, if_exists='replace', index=False)
df_spa_classificacao_tratado.to_sql('spa_classificacao', con, if_exists='replace', index=False)
df_spa_odontologia_tratado.to_sql('spa_odontologia', con, if_exists='replace', index=False)
                                
# Fechar a conexão com o banco de dados
con.close()

# Caminho para arquivos de Ouvidoria
path_ouvidoria = 'data_bruto/ouvidoria/Banco_de_Dados_Ouvidoria_do_SUS_Recife _2019_ate _o_dia_03_06_2024.xlsx'
df_base_ouvidoria_tratado = remove_espacos_e_acentos(path_ouvidoria)
col_base_ouvidoria = df_base_ouvidoria_tratado.columns.to_list()
print(col_base_ouvidoria)

# Abrir conexão com o banco de dados
con = sqlite3.connect('db_mac.sqlite')

# Escrever os DataFrames de Ouvidoria no banco de dados SQLite
df_base_ouvidoria_tratado.to_sql('base_ouvidoria', con, if_exists='replace', index=False)

# Cria tabela base_ouvidoria_mac
base_ouvidoria_mac = con.execute('''
    CREATE TABLE IF NOT EXISTS base_ouvidoria_mac (
        PROTOCOLO INTEGER,
        DATA_DA_DEMANDA DATE,
        DEMANDA_ATIVA TEXT,
        STATUS TEXT,
        DATA_DE_FECHAMENTO_DEMANDA DATE,
        DIAS_DE_TRAMITACAO INTEGER,
        PRAZO_VENCIDO TEXT,
        CLASSIFICACAO TEXT,
        ASSUNTO TEXT,
        SUBASSUNTO_01 TEXT,
        SUBASSUNTO_02 TEXT,
        SUBASSUNTO_03 TEXT,
        ESTAB_COMERCIAL TEXT,
        PRIMEIRO_DESTINO TEXT,
        DATA_PRIMEIRO_DESTINO_ENCAMINHAMENTO DATE,
        OUVIDORIA_SEGUNDO_ENCAMINHAMENTO TEXT,
        OUVIDORIA_TERCEIRO_ENCAMINHAMENTO TEXT,
        DESTINO_ATUAL TEXT,
        INDICADOR_RMAC TEXT    
    );
''')

con.close()


