# Dashboard SERMAC

## Descrição

Este repositório contém um projeto de ETL (Extração, Transformação e Carga) desenvolvido para automatizar o processo de coleta, transformação e carga de dados de Média e Alta Complexidade em Saúde. O objetivo é centralizar dados de diversas fontes para alimentar painéis de análise no Power BI, com dados transformados e organizados em um banco de dados PostgreSQL. O pipeline é implementado em Python, utilizando diversas bibliotecas e tecnologias para facilitar a extração de dados, transformação e carga.

## Funcionalidades

- **Extração**: Coleta de dados a partir de fontes diversas, incluindo Google Sheets, SharePoint e arquivos Excel.
- **Transformação**: Processamento e transformação dos dados para adequação ao modelo de dados, com integração e normalização das tabelas.
- **Carga**: Inserção dos dados transformados em um banco de dados PostgreSQL, estruturado em schemas específicos para organização dos dados.
- **Integração com Power BI**: Disponibilização dos dados processados para atualização direta dos painéis no Power BI.

## Estrutura do Projeto

O projeto é organizado conforme descrito abaixo:

- **src**: Contém o código principal de processamento de dados.
  - **data_processing**: Scripts para processamento e transformação de dados de diferentes fontes, como `atbasica.py`, `maternidades.py`, `obras.py`, etc.
  - **database**: Scripts para criar a conexão com o banco de dados PostgreSQL.
  - **sql_operations**: Scripts para operações SQL, como criação de schemas e execução de scripts SQL.
  - **utils**: Utilitários para tarefas comuns, como manipulação de planilhas Excel, autenticação com SharePoint e Google Sheets, e manipulação de chaves primárias.
- **scripts_main**: Scripts principais para execução do pipeline ETL.
  - **main.py**: Script principal para execução do pipeline ETL.
- **scripts_sql/transformacoes**: Scripts contendo transformações específicas para cada tabela.

## Tecnologias Utilizadas

- **Python**: Linguagem de programação utilizada para implementar o pipeline ETL.
- **PostgreSQL**: Banco de dados utilizado para armazenar os dados transformados.
- **DuckDB**: Utilizado para manipulação intermediária dos dados durante as transformações.
- **Poetry**: Gerenciador de dependências e ambientes para Python.
- **pyenv**: Utilizado para gerenciar diferentes versões do Python.
- **Google Sheets API e SharePoint API**: APIs utilizadas para extração de dados de fontes online.

## Pré-requisitos

Antes de executar o projeto, certifique-se de que você tem os seguintes itens instalados:

- Python 3.12 ou superior (gerenciado via pyenv)
- PostgreSQL
- Poetry

## Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/db-mac-secoge.git
   cd db-mac-secoge
