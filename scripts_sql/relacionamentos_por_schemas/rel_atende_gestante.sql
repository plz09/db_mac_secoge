-- Limpeza inicial de colunas desnecessárias na tabela 'conectazap'
DO $$
DECLARE
    column_name_info text; -- Usando um nome mais distinto para a variável
    columns_to_keep text[] := array[
        'id_conectazap', 'data', 'whatsapp', 'cns', 'roomid', 'acessou_com', 
        'nome', 'transbordo__horario', 'encerrado_na_susi', 'avaliacao'
    ];
    drop_columns_query text := 'ALTER TABLE atende_gestante.conectazap ';
BEGIN
    FOR column_name_info IN 
        SELECT col.column_name
        FROM information_schema.columns col
        WHERE col.table_name = 'conectazap' 
        AND col.table_schema = 'atende_gestante'
        AND col.column_name <> ALL(columns_to_keep)
    LOOP
        drop_columns_query := drop_columns_query || 'DROP COLUMN IF EXISTS "' || column_name_info || '", ';
    END LOOP;

    -- Remove the last comma and space
    drop_columns_query := left(drop_columns_query, length(drop_columns_query) - 2) || ';';

    -- Execute the dynamic query
    EXECUTE drop_columns_query;
END $$;

-- Remover dados inválidos da coluna 'data' antes de converter para DATE
DELETE FROM atende_gestante.conectazap
WHERE data !~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$' AND data IS NOT NULL;

-- Converter a coluna 'data' para DATE após limpeza
ALTER TABLE atende_gestante.conectazap
ALTER COLUMN data TYPE DATE USING CASE
    WHEN data ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$' THEN CAST(data AS DATE)
    ELSE NULL
END;

-- Limpeza e conversão da tabela 'avaliacao_diaria'
DELETE FROM atende_gestante.avaliacao_diaria
WHERE data !~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$' AND data IS NOT NULL;

ALTER TABLE atende_gestante.avaliacao_diaria
ALTER COLUMN data TYPE DATE USING CASE
    WHEN data ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$' THEN CAST(data AS DATE)
    ELSE NULL
END;

-- Converter outras colunas para INTEGER na tabela 'avaliacao_diaria'
ALTER TABLE atende_gestante.avaliacao_diaria
ALTER COLUMN geral TYPE INTEGER USING CAST(geral AS INTEGER),
ALTER COLUMN recepcao_digital TYPE INTEGER USING CAST(recepcao_digital AS INTEGER),
ALTER COLUMN teleconsulta_total TYPE INTEGER USING CAST(teleconsulta_total AS INTEGER),
ALTER COLUMN teleconsulta_efetivadas TYPE INTEGER USING CAST(teleconsulta_efetivadas AS INTEGER),
ALTER COLUMN telemonitoramento_com_sucesso TYPE INTEGER USING CAST(telemonitoramento_com_sucesso AS INTEGER),
ALTER COLUMN telemonitoramento_sem_sucesso TYPE INTEGER USING CAST(telemonitoramento_sem_sucesso AS INTEGER),
ALTER COLUMN suporte_ao_profissional_de_saude TYPE INTEGER USING CAST(suporte_ao_profissional_de_saude AS INTEGER),
ALTER COLUMN doulas TYPE INTEGER USING CAST(doulas AS INTEGER);

-- Tratamento da tabela 'registros_teleatendimentos'
ALTER TABLE atende_gestante.registros_teleatendimentos
ALTER COLUMN carimbo_de_datahora TYPE DATE USING CAST(carimbo_de_datahora AS DATE);

-- Relacionamento entre 'registros_teleatendimentos' e 'calendario'
ALTER TABLE atende_gestante.registros_teleatendimentos
ADD COLUMN fk_id_calendario_registros_teleatendimentos INTEGER;

UPDATE atende_gestante.registros_teleatendimentos tele 
SET fk_id_calendario_registros_teleatendimentos = id_calendario 
FROM calendario.calendario calend 
WHERE tele.carimbo_de_datahora = calend.data_dma;

ALTER TABLE atende_gestante.registros_teleatendimentos
ADD CONSTRAINT fk_id_calendario_registros_teleatendimentos FOREIGN KEY (fk_id_calendario_registros_teleatendimentos) REFERENCES calendario.calendario(id_calendario);

-- Relacionamento entre 'conectazap' e 'calendario'
ALTER TABLE atende_gestante.conectazap
ADD COLUMN fk_id_calendario_conectazap INTEGER;

UPDATE atende_gestante.conectazap zap 
SET fk_id_calendario_conectazap = id_calendario 
FROM calendario.calendario calend 
WHERE zap.data = calend.data_dma;

ALTER TABLE atende_gestante.conectazap
ADD CONSTRAINT fk_id_calendario_conectazap FOREIGN KEY (fk_id_calendario_conectazap) REFERENCES calendario.calendario(id_calendario);

-- Relacionamento entre 'avaliacao_diaria' e 'calendario'
ALTER TABLE atende_gestante.avaliacao_diaria
ADD COLUMN fk_id_calendario_avaliacao_diaria INTEGER;

UPDATE atende_gestante.avaliacao_diaria aval 
SET fk_id_calendario_avaliacao_diaria = id_calendario 
FROM calendario.calendario calend 
WHERE aval.data = calend.data_dma;

ALTER TABLE atende_gestante.avaliacao_diaria
ADD CONSTRAINT fk_id_calendario_avaliacao_diaria FOREIGN KEY (fk_id_calendario_avaliacao_diaria) REFERENCES calendario.calendario(id_calendario);
