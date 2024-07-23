
-- Convertendo tipo de dado das colunas de data para date

ALTER TABLE atbasica.consulta_prenatal
ALTER COLUMN co_dim_tempo TYPE DATE USING CAST(co_dim_tempo AS DATE)
;

ALTER TABLE atbasica.consulta_prenatal
ALTER COLUMN dpp TYPE DATE USING CAST(dpp AS DATE)
;


-- deletar duplicatas da tabela consulta_prenatal
WITH consultas_com_identificador AS (
    SELECT 
        ctid,
        COALESCE(CAST(nu_cpf_cidadao AS TEXT), CAST(nu_cns AS TEXT)) AS gestante_id,
        nu_cpf_cidadao,
        nu_cns,
        co_dim_tempo
    FROM 
        atbasica.consulta_prenatal
),
duplicatas AS (
    SELECT 
        ctid,
        ROW_NUMBER() OVER (
            PARTITION BY gestante_id, co_dim_tempo 
            ORDER BY ctid
        ) AS rn
    FROM 
        consultas_com_identificador
)
DELETE FROM atbasica.consulta_prenatal
WHERE ctid IN (
    SELECT ctid
    FROM duplicatas
    WHERE rn > 1
);


-- Adicionar as colunas co_dim_tempo_mes e co_dim_tempo_ano
ALTER TABLE atbasica.consulta_prenatal
ADD COLUMN co_dim_tempo_mes INTEGER,
ADD COLUMN co_dim_tempo_ano INTEGER
;

UPDATE atbasica.consulta_prenatal
SET 
    co_dim_tempo_mes = EXTRACT(MONTH FROM co_dim_tempo),
    co_dim_tempo_ano = EXTRACT(YEAR FROM co_dim_tempo)
;


-- criando coluna id_gestante
ALTER TABLE atbasica.consulta_prenatal
ADD COLUMN gestante_id BIGINT
;

UPDATE atbasica.consulta_prenatal
SET gestante_id = COALESCE(nu_cpf_cidadao::BIGINT, nu_cns::BIGINT)
;


--Criando coluna dpp_valido na tabela consulta_prenatal

ALTER TABLE atbasica.consulta_prenatal ADD COLUMN dpp_valido BOOLEAN;

UPDATE atbasica.consulta_prenatal
SET dpp_valido = (
    CASE
        WHEN dpp <> '1900-10-06' AND
             (nu_cpf_cidadao IS NOT NULL OR nu_cns IS NOT NULL) AND
             no_cidadao IS NOT NULL
        THEN TRUE
        ELSE FALSE
    END
);


-- Relacionamento de Atenção básica com unidades_mac

-- Tabela consulta_prenatal
ALTER TABLE atbasica.consulta_prenatal 
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE atbasica.consulta_prenatal prenatal
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE prenatal.cnes = tab_mac.cnes_padrao
;

ALTER TABLE atbasica.consulta_prenatal
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Convertendo tipo de colunas da tabela consulta_prenatal
ALTER TABLE atbasica.consulta_prenatal
ALTER COLUMN nu_cns TYPE BIGINT USING CAST(nu_cns AS BIGINT),
ALTER COLUMN nu_cpf_cidadao TYPE BIGINT USING CAST(nu_cpf_cidadao AS BIGINT),
ALTER COLUMN dt_nascimento TYPE DATE USING CAST(dt_nascimento AS DATE)
;

-- Dropando colunas desnecessárias

ALTER TABLE atbasica.consulta_prenatal
DROP COLUMN co_dim_unidade_saude_1,
DROP COLUMN no_unidade_saude,
DROP COLUMN	no_equipe,
DROP COLUMN	co_dim_equipe_1
;


-- Tabela consulta_puericultura

ALTER TABLE atbasica.consulta_puericultura 
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE atbasica.consulta_puericultura puericult
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE puericult.cnes = tab_mac.cnes_padrao
;

ALTER TABLE atbasica.consulta_puericultura
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Conversão de tipos da tabela consulta_puericultura

ALTER TABLE atbasica.consulta_puericultura
ALTER COLUMN nu_cns TYPE BIGINT USING CAST(nu_cns AS BIGINT),
ALTER COLUMN nu_cpf_cidadao TYPE BIGINT USING CAST(nu_cpf_cidadao AS BIGINT),
ALTER COLUMN co_dim_tempo TYPE DATE USING CAST(co_dim_tempo AS DATE),
ALTER COLUMN dt_nascimento TYPE DATE USING CAST(dt_nascimento AS DATE)
;

--  DRopando colunas desnecessárias da tabela consulta_puericultura

ALTER TABLE atbasica.consulta_puericultura
DROP COLUMN no_unidade_saude,
DROP COLUMN no_equipe,
DROP COLUMN	ds_proced
;

-- Tabela consulta_puerperal

ALTER TABLE atbasica.consulta_puerperal 
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE atbasica.consulta_puerperal pueperi
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE pueperi.cnes = tab_mac.cnes_padrao
;

ALTER TABLE atbasica.consulta_puerperal
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Convertendo tipos das colunas da tabela consulta_puerperal
ALTER TABLE atbasica.consulta_puerperal
ALTER COLUMN nu_cns TYPE BIGINT USING CAST(nu_cns AS BIGINT),
ALTER COLUMN nu_cpf_cidadao TYPE BIGINT USING CAST(nu_cpf_cidadao AS BIGINT),
ALTER COLUMN co_dim_tempo TYPE DATE USING CAST(co_dim_tempo AS DATE)
;

-- Dropando colunas desnecessárias

ALTER TABLE atbasica.consulta_puerperal
DROP COLUMN no_unidade_saude,
DROP COLUMN no_equipe,
DROP COLUMN	ds_proced
;

-- Tabela quantitativo_gestantes_acompanhadas

ALTER TABLE atbasica.quantitativo_gestantes_acompanhadas
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE atbasica.quantitativo_gestantes_acompanhadas qt_gest
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE qt_gest.cnes = tab_mac.cnes_padrao
;

ALTER TABLE atbasica.quantitativo_gestantes_acompanhadas
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Convertendo tipo de colunas na tabela quantitativo_gestantes_acompanhadas


ALTER TABLE atbasica.quantitativo_gestantes_acompanhadas
ALTER COLUMN mes TYPE date USING mes::date
;

-- Dropando colunas desnecessárias
ALTER TABLE atbasica.quantitativo_gestantes_acompanhadas
DROP COLUMN ds,
DROP COLUMN cnes,
DROP COLUMN	nome_fantasia,
DROP COLUMN	nome_equipe
;


-- rel consulta_prenatal com calendario

ALTER TABLE atbasica.consulta_prenatal
ADD COLUMN fk_id_calendario_atbasica_prenatal INTEGER
;

UPDATE atbasica.consulta_prenatal prenatal
SET fk_id_calendario_atbasica_prenatal = calend.id_calendario 
FROM calendario.calendario calend
WHERE prenatal.co_dim_tempo = calend.data_dma
;


ALTER TABLE atbasica.consulta_prenatal
ADD CONSTRAINT fk_id_calendario_atbasica_prenatal FOREIGN KEY (fk_id_calendario_atbasica_prenatal) REFERENCES calendario.calendario(id_calendario)
;

-- REL PUERICULTURA COM CALENDARIO

ALTER TABLE atbasica.consulta_puericultura
ADD COLUMN fk_id_calendario_atbasica_puericultura INTEGER
;

UPDATE atbasica.consulta_puericultura puericult
SET fk_id_calendario_atbasica_puericultura = calend.id_calendario
FROM calendario.calendario calend
WHERE puericult.co_dim_tempo = calend.data_dma
;

ALTER TABLE atbasica.consulta_puericultura 
ADD CONSTRAINT fk_id_calendario_atbasica_puericultura FOREIGN KEY (fk_id_calendario_atbasica_puericultura) REFERENCES calendario.calendario(id_calendario)
;

-- REL PUERPERAL COM CALENDARIO

ALTER TABLE atbasica.consulta_puerperal
ADD COLUMN fk_id_calendario_atbasica_puerperal INTEGER
;

UPDATE atbasica.consulta_puerperal puerp
SET fk_id_calendario_atbasica_puerperal = calend.id_calendario
FROM calendario.calendario calend
WHERE puerp.co_dim_tempo = calend.data_dma
;

ALTER TABLE atbasica.consulta_puerperal
ADD CONSTRAINT fk_id_calendario_atbasica_puerperal FOREIGN KEY (fk_id_calendario_atbasica_puerperal) REFERENCES calendario.calendario(id_calendario)
;

-- REL PUERPERAL COM CALENDARIO

ALTER TABLE atbasica.quantitativo_gestantes_acompanhadas
ADD COLUMN fk_id_calendario_atbasica_quantitativo_gest_acomp INTEGER
;

UPDATE atbasica.quantitativo_gestantes_acompanhadas qtt_gest
SET fk_id_calendario_atbasica_quantitativo_gest_acomp = calend.id_calendario 
FROM calendario.calendario calend
WHERE qtt_gest.mes = calend.data_dma
;

ALTER TABLE atbasica.quantitativo_gestantes_acompanhadas
ADD CONSTRAINT fk_id_calendario_atbasica_quantitativo_gest_acomp FOREIGN KEY (fk_id_calendario_atbasica_quantitativo_gest_acomp) REFERENCES calendario.calendario(id_calendario)
;