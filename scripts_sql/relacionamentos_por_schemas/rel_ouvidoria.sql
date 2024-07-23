-- Relacionamento ouvidoria com unidades

ALTER TABLE ouvidoria.ouvidoria
ADD COLUMN codigo_unidade VARCHAR
;

UPDATE ouvidoria.ouvidoria ouvi
SET codigo_unidade = LEFT(ouvi.estab_comercial, 6)
;

UPDATE ouvidoria.ouvidoria ouvi
SET codigo_unidade = REPLACE(LEFT(ouvi.estab_comercial, 6),'US ', '')
;

-- Deletando todas as linhas onde o valor da coluna codigo_unidade não inteiro:

-- Selecionar valores inválidos (que não são números inteiros)
SELECT codigo_unidade
FROM ouvidoria.ouvidoria
WHERE NOT (codigo_unidade ~ '^[0-9]+$')
;

-- Remover valores inválidos (que não são números inteiros)
DELETE FROM ouvidoria.ouvidoria
WHERE NOT (codigo_unidade ~ '^[0-9]+$')
;



-- Adicionar uma nova coluna temporária para conversão
ALTER TABLE ouvidoria.ouvidoria
ADD COLUMN codigo_unidade_temp INTEGER
;

-- Preencher a nova coluna com valores convertidos
UPDATE ouvidoria.ouvidoria
SET codigo_unidade_temp = codigo_unidade::INTEGER
;

-- Remover a coluna original e renomear a nova coluna
ALTER TABLE ouvidoria.ouvidoria
DROP COLUMN codigo_unidade
;

ALTER TABLE ouvidoria.ouvidoria
RENAME COLUMN codigo_unidade_temp TO codigo_unidade
;


-- Inserindo e defindo FK

ALTER TABLE ouvidoria.ouvidoria
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE ouvidoria.ouvidoria ouvi 
SET fk_id_unidades_mac = tab_mac.id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE ouvi.codigo_unidade = tab_mac.codigo_unidade
;

ALTER TABLE ouvidoria.ouvidoria
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- COnvertendo tipo de colunas da tabela ouvidoria


ALTER TABLE ouvidoria.ouvidoria
ALTER COLUMN data_da_demanda TYPE DATE USING CAST(data_da_demanda AS DATE),
ALTER COLUMN data_de_fechamento_da_demanda TYPE DATE USING CAST(data_de_fechamento_da_demanda AS DATE),
ALTER COLUMN data_de_conclusao_efetiva TYPE DATE USING CAST(data_de_conclusao_efetiva AS DATE),
ALTER COLUMN data_de_conclusao_prevista TYPE DATE USING CAST(data_de_conclusao_prevista AS DATE),
ALTER COLUMN data_primeiro_destino_encaminhamento TYPE DATE USING CAST(data_primeiro_destino_encaminhamento AS DATE),
ALTER COLUMN data_do_acomp_atual TYPE DATE USING CAST(data_do_acomp_atual AS DATE)
;

-- REL OUVIDORIA COM CALENDARIO

ALTER TABLE ouvidoria.ouvidoria
ADD COLUMN fk_id_calendario_ouvidoria INTEGER
;

UPDATE ouvidoria.ouvidoria ouvi
SET fk_id_calendario_ouvidoria = id_calendario 
FROM calendario.calendario calend 
WHERE ouvi.data_da_demanda = calend.data_dma 
;

ALTER TABLE ouvidoria.ouvidoria 
ADD CONSTRAINT fk_id_calendario_ouvidoria FOREIGN KEY (fk_id_calendario_ouvidoria) REFERENCES calendario.calendario(id_calendario)
;