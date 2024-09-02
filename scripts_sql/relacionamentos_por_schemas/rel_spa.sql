
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

/*
    Foi necessário atualizar o nome do campo da coluna de unidade da tabela spa_classificacao
    porque nessa coluna o valor é 'PAM' que não será entrada no 'LIKE' código a seguir, pois
    o nome da unidade da tabela de unidades é  'Us 159 Policlinica Agamenon Magalhaes'
*/

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

ALTER TABLE spa.spa_classificacao
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- SPA Classificação Pediatria

ALTER TABLE spa.spa_classificacaopediatria
ADD COLUMN fk_id_unidades_mac INTEGER
;

/*
    Foi necessário atualizar o nome do campo da coluna de unidade da tabela spa_clinico
    porque existem duas unidades com 'Cravo Gama' no nome, e isso causaria problemas ao
    usar o 'LIKE' no codigo de UPDATE da chave estrangeira 'fk_id_unidades_mac'.
*/

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

ALTER TABLE spa.spa_classificacaopediatria
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;
-- SPA Clínico

ALTER TABLE spa.spa_clinico
ADD COLUMN fk_id_unidades_mac INTEGER
;

/*
    Foi necessário atualizar o nome do campo da coluna de unidade da tabela spa_clinico
    porque nessa coluna o valor é 'PAM' que não será entrada no 'LIKE' código a seguir, pois
    o nome da unidade da tabela de unidades é  'Us 159 Policlinica Agamenon Magalhaes'
*/
UPDATE spa.spa_clinico  
SET unidade = 'Us 159 Policlinica Agamenon Magalhaes'
WHERE unidade = 'PAM'
;

UPDATE spa.spa_clinico spacli
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spacli.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac 
    WHERE tab_mac.nome LIKE CONCAT('%', spacli.unidade, '%')
)
;

ALTER TABLE spa.spa_clinico
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;
-- Relacionamento de spa_isolamentopediatria com unidades_mac


ALTER TABLE spa.spa_isolamentopediatria
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE spa.spa_isolamentopediatria
SET unidade = 'US 164 CENTRO DE REIDRATACAO E URG PED M CRAVO GAMA'
WHERE unidade = 'Cravo Gama'
;

UPDATE spa.spa_isolamentopediatria spaisoped
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaisoped.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaisoped.unidade, '%')
)
;

ALTER TABLE spa.spa_isolamentopediatria
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Relacionamento entre spa_odontologia e unidades_mac

ALTER TABLE spa.spa_odontologia 
ADD COLUMN fk_id_unidades_mac INTEGER
;

/*
    Foi necessário atualizar o nome do campo da coluna de unidade da tabela spa_odontologia
    porque nessa coluna o valor é 'PAM', e não será entrada no 'LIKE' do código a seguir, pois
    o nome da unidade da tabela de unidades é  'Us 159 Policlinica Agamenon Magalhaes'.
*/
UPDATE spa.spa_odontologia   
SET unidade = 'Us 159 Policlinica Agamenon Magalhaes'
WHERE unidade = 'PAM'
;


UPDATE spa.spa_odontologia spaodonto
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaodonto.unidade, '%')
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaodonto.unidade, '%')
)
;

ALTER TABLE spa.spa_odontologia
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Relacionamento de spa_ortopedia com unidades_mac

ALTER TABLE spa.spa_ortopedia
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE spa.spa_ortopedia spaortoped 
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaortoped.unidade, '%')
)
WHERE EXISTS(
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spaortoped.unidade, '%')
)
;

ALTER TABLE spa.spa_ortopedia
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Relacionamento de spa_pediatria com unidades_mac

ALTER TABLE spa.spa_pediatria
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE spa.spa_pediatria
SET unidade = 'US 164 CENTRO DE REIDRATACAO E URG PED M CRAVO GAMA'
WHERE unidade LIKE '%Cravo Grama%'
;

UPDATE spa.spa_pediatria spapediat  
SET fk_id_unidades_mac = (
    SELECT tab_mac.id_unidades_mac
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spapediat.unidade, '%')
)
WHERE EXISTS(
    SELECT 1
    FROM ds_unidades.unidades_mac tab_mac
    WHERE tab_mac.nome LIKE CONCAT('%', spapediat.unidade, '%')
)
;

ALTER TABLE spa.spa_pediatria
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;


-- Alterando campo para data para tipo date para relacionametno com calendario


-- spa_cirurgia

ALTER TABLE spa.spa_cirurgia ADD COLUMN data_new DATE;
UPDATE spa.spa_cirurgia
SET data_new = DATE(data);
;

ALTER TABLE spa.spa_cirurgia DROP COLUMN data
;

-- spa_classificacao
ALTER TABLE spa.spa_classificacao ADD COLUMN data_new DATE;
UPDATE spa.spa_classificacao
SET data_new = DATE(data);
ALTER TABLE spa.spa_classificacao DROP COLUMN data;

-- spa_classificacaopediatria
ALTER TABLE spa.spa_classificacaopediatria ADD COLUMN data_new DATE;
UPDATE spa.spa_classificacaopediatria
SET data_new = DATE(data);
ALTER TABLE spa.spa_classificacaopediatria DROP COLUMN data;

-- spa_clinico
ALTER TABLE spa.spa_clinico ADD COLUMN data_new DATE;
UPDATE spa.spa_clinico
SET data_new = DATE(data);
ALTER TABLE spa.spa_clinico DROP COLUMN data;

-- spa_isolamentopediatria
ALTER TABLE spa.spa_isolamentopediatria ADD COLUMN data_new DATE;
UPDATE spa.spa_isolamentopediatria
SET data_new = DATE(data);
ALTER TABLE spa.spa_isolamentopediatria DROP COLUMN data;

-- spa_odontologia
ALTER TABLE spa.spa_odontologia ADD COLUMN data_new DATE;
UPDATE spa.spa_odontologia
SET data_new = DATE(data);
ALTER TABLE spa.spa_odontologia DROP COLUMN data;

-- spa_ortopedia
ALTER TABLE spa.spa_ortopedia ADD COLUMN data_new DATE;
UPDATE spa.spa_ortopedia
SET data_new = DATE(data);
ALTER TABLE spa.spa_ortopedia DROP COLUMN data;

-- spa_pediatria
ALTER TABLE spa.spa_pediatria ADD COLUMN data_new DATE;
UPDATE spa.spa_pediatria
SET data_new = DATE(data);
ALTER TABLE spa.spa_pediatria DROP COLUMN data;


-- Relacionamento de SPA com calendario:

-- spa_cirurgia

ALTER TABLE spa.spa_cirurgia
ADD COLUMN fk_id_calendario_spacirurgia INTEGER
;

UPDATE spa.spa_cirurgia cirurgia 
SET fk_id_calendario_spacirurgia = calend.id_calendario 
FROM calendario.calendario calend
WHERE cirurgia.data_new = calend.data_dma
;


ALTER TABLE spa.spa_cirurgia
ADD CONSTRAINT fk_id_calendario_spacirurgia FOREIGN KEY (fk_id_calendario_spacirurgia) REFERENCES calendario.calendario(id_calendario)
;

-- spa_classificacao
ALTER TABLE spa.spa_classificacao
ADD COLUMN fk_id_calendario_spaclassificacao INTEGER;

UPDATE spa.spa_classificacao classificacao
SET fk_id_calendario_spaclassificacao = calend.id_calendario
FROM calendario.calendario calend
WHERE classificacao.data_new = calend.data_dma;

ALTER TABLE spa.spa_classificacao
ADD CONSTRAINT fk_id_calendario_spaclassificacao FOREIGN KEY (fk_id_calendario_spaclassificacao) REFERENCES calendario.calendario(id_calendario);

-- spa_classificacaopediatria
ALTER TABLE spa.spa_classificacaopediatria
ADD COLUMN fk_id_calendario_spaclassificacaopediatria INTEGER;

UPDATE spa.spa_classificacaopediatria classificacaopediatria
SET fk_id_calendario_spaclassificacaopediatria = calend.id_calendario
FROM calendario.calendario calend
WHERE classificacaopediatria.data_new = calend.data_dma;

ALTER TABLE spa.spa_classificacaopediatria
ADD CONSTRAINT fk_id_calendario_spaclassificacaopediatria FOREIGN KEY (fk_id_calendario_spaclassificacaopediatria) REFERENCES calendario.calendario(id_calendario);

-- spa_clinico
ALTER TABLE spa.spa_clinico
ADD COLUMN fk_id_calendario_spaclinico INTEGER;

UPDATE spa.spa_clinico clinico
SET fk_id_calendario_spaclinico = calend.id_calendario
FROM calendario.calendario calend
WHERE clinico.data_new = calend.data_dma;

ALTER TABLE spa.spa_clinico
ADD CONSTRAINT fk_id_calendario_spaclinico FOREIGN KEY (fk_id_calendario_spaclinico) REFERENCES calendario.calendario(id_calendario);

-- spa_isolamentopediatria
ALTER TABLE spa.spa_isolamentopediatria
ADD COLUMN fk_id_calendario_spaisolamentopediatria INTEGER;

UPDATE spa.spa_isolamentopediatria isolamentopediatria
SET fk_id_calendario_spaisolamentopediatria = calend.id_calendario
FROM calendario.calendario calend
WHERE isolamentopediatria.data_new = calend.data_dma;

ALTER TABLE spa.spa_isolamentopediatria
ADD CONSTRAINT fk_id_calendario_spaisolamentopediatria FOREIGN KEY (fk_id_calendario_spaisolamentopediatria) REFERENCES calendario.calendario(id_calendario);

-- spa_odontologia
ALTER TABLE spa.spa_odontologia
ADD COLUMN fk_id_calendario_spaodontologia INTEGER;

UPDATE spa.spa_odontologia odontologia
SET fk_id_calendario_spaodontologia = calend.id_calendario
FROM calendario.calendario calend
WHERE odontologia.data_new = calend.data_dma;

ALTER TABLE spa.spa_odontologia
ADD CONSTRAINT fk_id_calendario_spaodontologia FOREIGN KEY (fk_id_calendario_spaodontologia) REFERENCES calendario.calendario(id_calendario);

-- spa_ortopedia
ALTER TABLE spa.spa_ortopedia
ADD COLUMN fk_id_calendario_spaortopedia INTEGER;

UPDATE spa.spa_ortopedia ortopedia
SET fk_id_calendario_spaortopedia = calend.id_calendario
FROM calendario.calendario calend
WHERE ortopedia.data_new = calend.data_dma;

ALTER TABLE spa.spa_ortopedia
ADD CONSTRAINT fk_id_calendario_spaortopedia FOREIGN KEY (fk_id_calendario_spaortopedia) REFERENCES calendario.calendario(id_calendario);

-- spa_pediatria
ALTER TABLE spa.spa_pediatria
ADD COLUMN fk_id_calendario_spapediatria INTEGER;

UPDATE spa.spa_pediatria pediatria
SET fk_id_calendario_spapediatria = calend.id_calendario
FROM calendario.calendario calend
WHERE pediatria.data_new = calend.data_dma;

ALTER TABLE spa.spa_pediatria
ADD CONSTRAINT fk_id_calendario_spapediatria FOREIGN KEY (fk_id_calendario_spapediatria) REFERENCES calendario.calendario(id_calendario);



