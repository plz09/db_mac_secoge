
-- Relacionamentos de unidades_mac com SPA
-- SPA Cirurgia

ALTER TABLE spa.spa_cirurgia
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE spa.spa_cirurgia spacir 
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac 
WHERE tab_mac.nome LIKE '%Arnaldo Marques%'
;

ALTER TABLE spa.spa_cirurgia
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- SPA Classificção

ALTER TABLE spa.spa_classificacao
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE spa.spa_classificacao  
SET unidade = 'Us 159 Policlinica Agamenon Magalhaes'
WHERE unidade = 'PAM'
;

UPDATE spa.spa_classificacao spaclass
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaclass.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', spaclass.unidade, '%')
)
;

-- SPA Classificação Pediatria

ALTER TABLE spa.spa_classificacaopediatria
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE spa.spa_classificacaopediatria
SET unidade = 'US 164 CENTRO DE REIDRATACAO E URG PED M CRAVO GAMA'
WHERE unidade = 'Cravo Gama'
;

UPDATE spa.spa_classificacaopediatria spaclassped
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaclassped.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaclassped.unidade, '%')
)
;


-- SPA Clínico

