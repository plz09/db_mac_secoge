-- Removendo duplicatas da tabela consulta_prental

ALTER TABLE atbasica.consulta_prenatal ADD COLUMN is_duplicate BOOLEAN DEFAULT FALSE;

WITH cte_duplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY co_dim_tempo, COALESCE(nu_cpf_cidadao, nu_cns) ORDER BY co_dim_tempo) AS row_num
    FROM
        atbasica.consulta_prenatal
)
UPDATE
    atbasica.consulta_prenatal
SET
    is_duplicate = TRUE
FROM
    cte_duplicates
WHERE
    atbasica.consulta_prenatal.id_consulta_prenatal = cte_duplicates.id_consulta_prenatal
    AND cte_duplicates.row_num > 1
;


DELETE FROM atbasica.consulta_prenatal
WHERE is_duplicate = TRUE
;

ALTER TABLE atbasica.consulta_prenatal
DROP COLUMN is_duplicate
;

--Criando coluna dpp_calido na tabela consulta_prenatal

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
