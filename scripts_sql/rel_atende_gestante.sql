-- Relacionamento de quantitativo_gestantes_acompanhadas com unidades_mac

ALTER TABLE atende_gestante.qt_gest_acompanhadas
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE atende_gestante.qt_gest_acompanhadas qt_gest
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE qt_gest.cnes = tab_mac.cnes_padrao
;

ALTER TABLE atende_gestante.qt_gest_acompanhadas
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;



-- Tratamento da coluna conectazap

DO $$
DECLARE
    column_name text;
    columns_to_keep text[] := array[
        'id_conectazap', 'data', 'whatsapp', 'cns', 'roomid', 'acessou_com', 
        'nome', 'transbordo__horario', 'encerrado_na_susi', 'avaliacao'
    ];
    drop_columns_query text := 'ALTER TABLE atende_gestante.conectazap ';
BEGIN
    FOR column_name IN 
        SELECT col.column_name
        FROM information_schema.columns col
        WHERE col.table_name = 'conectazap' 
        AND col.table_schema = 'atende_gestante'
        AND col.column_name <> ALL(columns_to_keep)
    LOOP
        drop_columns_query := drop_columns_query || 'DROP COLUMN "' || column_name || '", ';
    END LOOP;

    -- Remove the última vírgula e espaço
    drop_columns_query := left(drop_columns_query, length(drop_columns_query) - 2) || ';';

    -- Execute a query dinâmica
    EXECUTE drop_columns_query;
END $$
;


-- Remover valores inválidos (que não são datas válidas)
DELETE FROM atende_gestante.conectazap
WHERE NOT (data ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
OR data IS NULL
;

-- Converter a coluna para DATE
ALTER TABLE atende_gestante.conectazap
ALTER COLUMN data TYPE DATE USING CAST(data AS DATE)
;


-- Tratando tabela avaliacao_diaria

DELETE FROM atende_gestante.avaliacao_diaria
WHERE NOT (data ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
OR data IS NULL
;

-- Converter a coluna para DATE
ALTER TABLE atende_gestante.avaliacao_diaria
ALTER COLUMN data TYPE DATE USING CAST(data AS DATE)
;


-- Convertendos demais colunas para INTEGER

ALTER TABLE atende_gestante.avaliacao_diaria
ALTER COLUMN geral TYPE INTEGER USING CAST(geral AS INTEGER)
;

ALTER TABLE atende_gestante.avaliacao_diaria
ALTER COLUMN recepcao_digital TYPE INTEGER USING CAST(recepcao_digital AS INTEGER),
ALTER COLUMN teleconsulta_total TYPE INTEGER USING CAST(teleconsulta_total AS INTEGER),
ALTER COLUMN teleconsulta_efetivadas TYPE INTEGER USING CAST(teleconsulta_efetivadas AS INTEGER),
ALTER COLUMN telemonitoramento_com_sucesso TYPE INTEGER USING CAST(telemonitoramento_com_sucesso AS INTEGER),
ALTER COLUMN suporte_ao_profissional_de_saude TYPE INTEGER USING CAST(suporte_ao_profissional_de_saude AS INTEGER),
ALTER COLUMN doulas TYPE INTEGER USING CAST(doulas AS INTEGER)
;


-- Tratando tabela registros_teleatendimentos

-- Remove valores inválidos (que não são datas válidas)
DELETE FROM atende_gestante.registros_teleatendimentos
WHERE NOT (carimbo_de_datahora ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
OR carimbo_de_datahora IS NULL
;

-- Converte a coluna para DATE
ALTER TABLE atende_gestante.registros_teleatendimentos
ALTER COLUMN carimbo_de_datahora TYPE TIMESTAMP USING CAST(carimbo_de_datahora AS TIMESTAMP)
;



DELETE FROM atende_gestante.registros_teleatendimentos
WHERE NOT (data_de_nascimento ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
OR data_de_nascimento IS NULL
;

ALTER TABLE atende_gestante.registros_teleatendimentos
ALTER COLUMN data_de_nascimento TYPE TIMESTAMP USING CAST(data_de_nascimento AS TIMESTAMP)
;


DELETE FROM atende_gestante.registros_teleatendimentos
WHERE NOT (dum ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$')
OR dum IS NULL
;

ALTER TABLE atende_gestante.registros_teleatendimentos
ALTER COLUMN dum TYPE TIMESTAMP USING CAST(dum AS TIMESTAMP)
;



ALTER TABLE atende_gestante.registros_teleatendimentos
ALTER COLUMN cns TYPE BIGINT USING CAST(cns AS BIGINT)
;