
-- Relacionamentos de unidades_mac com SPA

ALTER TABLE spa.spacirurgia
ADD COLUMN fk_unidades_mac INTEGER
;

UPDATE spa.spacirurgia spacir 
SET unidade = nome
FROM ds_unidades.unidades_mac tab_mac 
WHERE tab_mac.nome LIKE '%Arnaldo Marques%'
;

UPDATE spa.spacirurgia spacir 
SET fk_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac 
WHERE tab_mac.nome LIKE '%Arnaldo Marques%'
;

ALTER TABLE spa.spacirurgia
ADD CONSTRAINT fk_unidades_mac FOREIGN KEY (fk_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;