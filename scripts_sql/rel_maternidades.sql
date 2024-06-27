-- Definindo relacionametnos das tabelas de maternidade com unidades_mac

-- Definindo relacionametnos das tabelas de mat_classificacao com unidades_mac
-- HMR = Hospital Da Mulher Do Recife

ALTER TABLE maternidades.mat_classificacao
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE maternidades.mat_classificacao  
SET unidade = 'Hospital Da Mulher Do Recife'
WHERE unidade = 'HMR'
;

UPDATE maternidades.mat_classificacao matclass 
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', matclass.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', matclass.unidade, '%')
)
;

ALTER TABLE maternidades.mat_classificacao
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;


-- Definindo relacionametnos das tabelas de mat_leitos com unidades_mac
-- HMR = Hospital Da Mulher Do Recife

ALTER TABLE maternidades.mat_leitos
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE maternidades.mat_leitos  
SET unidade = 'Hospital Da Mulher Do Recife'
WHERE unidade = 'HMR'
;

UPDATE maternidades.mat_leitos matleitos 
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', matleitos.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', matleitos.unidade, '%')
)
;

ALTER TABLE maternidades.mat_leitos 
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;


-- Definindo relacionametnos das tabelas de mat_procedi_atend com unidades_mac

ALTER TABLE maternidades.mat_procedi_atend
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE maternidades.mat_procedi_atend  
SET unidade = 'Hospital Da Mulher Do Recife'
WHERE unidade = 'HMR'
;

UPDATE maternidades.mat_procedi_atend matproc  
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', matproc.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', matproc.unidade, '%')
)
;

ALTER TABLE maternidades.mat_procedi_atend 
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Definindo relacionametnos das tabelas de mat_triagem com unidades_mac

ALTER TABLE maternidades.mat_triagem
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE maternidades.mat_triagem  
SET unidade = 'Hospital Da Mulher Do Recife'
WHERE unidade = 'HMR'
;

UPDATE maternidades.mat_triagem mattri  
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', mattri.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', mattri.unidade, '%')
)
;

ALTER TABLE maternidades.mat_triagem 
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Definindo relacionametnos das tabelas de municipiosdeorigem com unidades_mac

ALTER TABLE maternidades.municipiosdeorigem
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE maternidades.municipiosdeorigem  
SET unidade = 'Hospital Da Mulher Do Recife'
WHERE unidade = 'HMR'
;

UPDATE maternidades.municipiosdeorigem municipiosorig  
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', municipiosorig.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', municipiosorig.unidade, '%')
)
;

ALTER TABLE maternidades.municipiosdeorigem 
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;