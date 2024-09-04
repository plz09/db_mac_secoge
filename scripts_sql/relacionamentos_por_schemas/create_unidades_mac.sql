
-- Cria e popula tabela unidades_mac

CREATE TABLE IF NOT EXISTS ds_unidades.unidades_mac (
		id_unidades_mac SERIAL PRIMARY KEY,
        cnes_padrao INTEGER,
        codigo_unidade INTEGER,
        distrito INTEGER,
        nome CHARACTER VARYING,
        tipo_servi CHARACTER VARYING
    );

INSERT INTO 
    ds_unidades.unidades_mac (cnes_padrao, codigo_unidade, distrito, nome, tipo_servi)
SELECT 
    cnes_padrao, 
    no_da_us,
    ds, 
    nome_fantasia, 
    tipo_servi
FROM 
    ds_unidades.unidades
;

ALTER TABLE ds_unidades.unidades_mac
ADD COLUMN ds_romano VARCHAR
;

UPDATE ds_unidades.unidades_mac tab_mac
SET ds_romano = tab_ds.ds_romano
FROM ds_unidades.distritos tab_ds
WHERE tab_mac.distrito = tab_ds.ds
;


-- Define relacionamento entre unidades_mac e ditritos inserindo FK em unidades_mac

ALTER TABLE ds_unidades.unidades_mac
ADD COLUMN fk_id_distritos INTEGER
;

UPDATE ds_unidades.unidades_mac tab_mac
SET fk_id_distritos = id_distritos
FROM ds_unidades.distritos tab_ds
WHERE tab_mac.distrito = tab_ds.ds
;

ALTER TABLE ds_unidades.unidades_mac
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;
  
-- relacionamento de login_unidades com unidades_mac

ALTER TABLE ds_unidades.unidades_mac
ADD COLUMN fk_id_login_senha INTEGER
;

UPDATE ds_unidades.unidades_mac tab_mac
SET fk_id_login_senha = id_login_unidades
FROM ds_unidades.login_unidades tab_log_uni
WHERE tab_mac.cnes_padrao = tab_log_uni.cnes
;

ALTER TABLE ds_unidades.unidades_mac 
ADD CONSTRAINT fk_id_login_senha FOREIGN KEY (fk_id_login_senha) REFERENCES ds_unidades.login_unidades(id_login_unidades)
;


-- relacionamento de login_ds com unidades_mac

ALTER TABLE ds_unidades.unidades_mac
ADD COLUMN fk_id_login_ds INTEGER
;

UPDATE ds_unidades.unidades_mac tab_mac
SET fk_id_login_ds = id_login_ds
FROM ds_unidades.login_ds tab_log_ds
WHERE tab_mac.ds_romano = tab_log_ds.ds_romano
;

ALTER TABLE ds_unidades.unidades_mac 
ADD CONSTRAINT fk_id_login_ds FOREIGN KEY (fk_id_login_ds) REFERENCES ds_unidades.login_unidades(id_login_unidades)
;