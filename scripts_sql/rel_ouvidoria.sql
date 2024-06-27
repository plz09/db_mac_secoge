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