-- codigo para criar e popular tabela unidades_mac
/*
CREATE TABLE IF NOT EXISTS ds_unidades.unidades_mac (
		id_unidades_mac SERIAL PRIMARY KEY,
        cnes_padrao INTEGER,
        codigo_unidade INTEGER,
        distrito INTEGER,
        nome CHARACTER VARYING,
        tipo_servi CHARACTER VARYING
    );

INSERT INTO ds_unidades.unidades_mac (id_unidades_mac, cnes_padrao, codigo_unidade, distrito, nome, tipo_servi)
SELECT id_unidades, cnes_padrao, no_da_us, ds, nome_fantasia, tipo_servi
FROM ds_unidades.unidades;
*/

-- Difinindo FK de Distritos

ALTER TABLE ds_unidades.unidades_mac
ADD COLUMN fk_distritos INTEGER
;

UPDATE ds_unidades.unidades_mac tab_mac
SET fk_distritos = id_distritos
FROM ds_unidades.distritos tab_ds
WHERE tab_mac.distrito = tab_ds.ds
;

ALTER TABLE ds_unidades.unidades_mac
ADD CONSTRAINT fk_distritos FOREIGN KEY (fk_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;
  

