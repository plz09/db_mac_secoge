-- Definindo relacionametnos das tabelas de mae_coruja com ds_unidades.distritos

-- Rel de mae_coruja.espacos com ds_unidades.distritos

ALTER TABLE mae_coruja.espacos
ADD COLUMN fk_id_distritos INTEGER
;

UPDATE mae_coruja.espacos mae_co_espacos 
SET fk_id_distritos = ds.id_distritos 
FROM ds_unidades.distritos ds 
WHERE REPLACE(mae_co_espacos.ds, ' ', '') = ds.ds_romano 
   OR REPLACE(mae_co_espacos.ds, '7 DSs', 'VII') = ds.ds_romano
;

ALTER TABLE mae_coruja.espacos
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;

-- Relacionamento de mae_coruja.espacos_bairros_cobertos com ds_unidades.distritos

ALTER TABLE mae_coruja.espacos_bairros_cobertos
ADD COLUMN fk_id_distritos INTEGER
;

UPDATE mae_coruja.espacos_bairros_cobertos mae_co_espac_cobertos 
SET fk_id_distritos = ds.id_distritos 
FROM ds_unidades.distritos ds 
WHERE REPLACE(mae_co_espac_cobertos.ds, ' ', '') = ds.ds_romano 
;

ALTER TABLE mae_coruja.espacos_bairros_cobertos
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;

-- Relacionamento espacos_unidades com distritos

