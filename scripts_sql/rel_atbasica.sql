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


