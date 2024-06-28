-- Relacionamento do schema producao entre  si entre e com unidades_mac

-- Unificando dcbo com dport157

-- Verificando valores faltantes em dcbo que existem em dport157

/*
SELECT 
    dcbo.cbo AS dcbo_cbo,
    CAST(dport.cbo AS TEXT) AS dport_cbo,
	dport.especialidade
FROM 
    producao.dcbo dcbo
RIGHT JOIN
    producao.dport157 dport
ON 
    dcbo.cbo = CAST(dport.cbo AS TEXT)
;

*/
-- Inserindo valores faltantes

INSERT INTO producao.dcbo (cbo, ds_cbo)
VALUES 
('223117', 'MEDICO DERMATOLOGISTA HANSENOLOGO'),
('223142', 'MEDICO NEUROPEDIATRA')
;

ALTER TABLE producao.dcbo
ADD COLUMN procedimentos INTEGER
;

UPDATE producao.dcbo dcbo
SET procedimentos = dport.procedimentos
FROM producao.dport157 dport
WHERE dcbo.cbo = CAST(dport.cbo AS TEXT)
;

DROP TABLE producao.dport157
;


-- Dropando colunas desnecessárias em fproducao2024

ALTER TABLE producao.fproducao2024
DROP COLUMN geometry
;
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

-- Rel fproducao2024 com dformaorganiz

ALTER TABLE producao.fproducao2024
ADD COLUMN fk_id_dformaorganiz INTEGER
;

UPDATE producao.fproducao2024 fprod
SET fk_id_dformaorganiz = dform.id_dformaorganiz
FROM producao.dformaorganiz dform
WHERE dform.forma_org = LEFT(fprod.pa_proc_id::TEXT, 5)::INTEGER
;


ALTER TABLE producao.fproducao2024
ADD CONSTRAINT fk_id_dformaorganiz FOREIGN KEY (fk_id_dformaorganiz) REFERENCES producao.dformaorganiz(id_dformaorganiz)
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

-- Rel dextrato_profissionais_sus com unidades_mac

ALTER TABLE producao.dextrato_profissionais_sus
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE producao.dextrato_profissionais_sus dextrat
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE tab_mac.cnes_padrao = dextrat.cnes
;

ALTER TABLE producao.dextrato_profissionais_sus
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Rel dextrato_profissionais_sus com unidades_mac com dcbo

ALTER TABLE producao.dextrato_profissionais_sus
ADD COLUMN fk_id_dcbo INTEGER
;

UPDATE producao.dextrato_profissionais_sus dextrat
SET fk_id_dcbo = id_dcbo 
FROM producao.dcbo dcbo
WHERE dcbo.cbo = dextrat.profissional_cbo
;

ALTER TABLE producao.dextrato_profissionais_sus
ADD CONSTRAINT fk_id_dcbo FOREIGN KEY (fk_id_dcbo) REFERENCES producao.dcbo(id_dcbo)
;
