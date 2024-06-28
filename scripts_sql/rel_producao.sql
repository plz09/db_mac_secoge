-- Relacionamento do schema -producao entre  si entre e com unidades_mac

-- Rel fproducao2024 com dcbo

ALTER TABLE producao.fproducao2024
ADD COLUMN fk_id_dcbo INTEGER
;

UPDATE producao.fproducao2024 fprod
SET fk_id_dcbo = id_dcbo 
FROM producao.dcbo dcbo
WHERE dcbo.cbo = fprod.pa_cbocod
;

ALTER TABLE producao.fproducao2024
ADD CONSTRAINT fk_id_dcbo FOREIGN KEY (fk_id_dcbo) REFERENCES producao.dcbo(id_dcbo)
;

-- Rel fproducao2024 com unidades_mac

ALTER TABLE producao.fproducao2024
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE producao.fproducao2024 fprod
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE tab_mac.cnes_padrao = fprod.pa_coduni
;

ALTER TABLE producao.fproducao2024
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Rel fproducao2024 com formaorganiz

ALTER TABLE producao.fproducao2024
ADD COLUMN fk_id_dformaorganiz INTEGER
;

UPDATE producao.fproducao2024 fprod
SET fk_id_dformaorganiz = id_dformaorganiz 
FROM producao.dformaorganiz dform
WHERE dform.forma_org = fprod.pa_proc_id
;

ALTER TABLE producao.fproducao2024
ADD CONSTRAINT fk_id_dformaorganiz FOREIGN KEY (fk_id_dformaorganiz) REFERENCES producao.formaorganiz(id_did_formaorganizcbo)
;



-- Rel com fprofissionais com unidades_mac

ALTER TABLE producao.fprofissionais
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE producao.fprofissionais fprof
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE tab_mac.cnes_padrao = fprof.cnes
;

ALTER TABLE producao.fprofissionais
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Rel fprofissionais com dcbo

ALTER TABLE producao.fprofissionais
ADD COLUMN fk_id_dcbo INTEGER
;

UPDATE producao.fprofissionais fprof
SET fk_id_dcbo = id_dcbo 
FROM producao.dcbo dcbo
WHERE dcbo.cbo = fprof.cbo
;

ALTER TABLE producao.fprofissionais
ADD CONSTRAINT fk_id_dcbo FOREIGN KEY (fk_id_dcbo) REFERENCES producao.dcbo(id_dcbo)
;

