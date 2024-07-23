-- Alterando tipos nas colunas das tabelas horus

ALTER TABLE horus.dispensa_medicamentos
ALTER COLUMN data TYPE date USING data::date
;


ALTER TABLE horus.historico_pacientes
ALTER COLUMN data_saida TYPE date USING data_saida::date
;

-- Dropando colunas desnecessárias

ALTER TABLE horus.historico_pacientes
DROP COLUMN cartao_sus,
DROP COLUMN paciente,
DROP COLUMN data_nascimento,
DROP COLUMN sexo,
DROP COLUMN data_cadastro,
DROP COLUMN codigo_programa,
DROP COLUMN programa
;


ALTER TABLE horus.dispensa_medicamentos
DROP COLUMN nome_produto,
DROP COLUMN unidade_produto,
DROP COLUMN programa_de_saude,
DROP COLUMN ds_unid_solicitante
;

-- Relacionametno de horus.dispensa_medicamentos com unidades_mac
-- OBS: O cnes_unid_solicitante = 6664288 de horus.dispensa_medicamentos não existe na tabela unidades_mac porque é referente ao Programa de Saúde.

ALTER TABLE horus.dispensa_medicamentos
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE horus.dispensa_medicamentos dismed
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE tab_mac.cnes_padrao = dismed.cnes_unid_solicitante
;

ALTER TABLE horus.dispensa_medicamentos
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Relacionamento de horus.historico_pacientes com unidades_mac

ALTER TABLE horus.historico_pacientes
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE horus.historico_pacientes his 
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE tab_mac.cnes_padrao = his.cnes 
;

ALTER TABLE horus.historico_pacientes
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

/*

OBS:
A consulta abaixo mostra os cnes da tabela de horus.historico_pacientes que estao desatualizados e por isso causam FK null

select 
	distinct unidade_saude_saida,
	cnes
from 
	horus.historico_pacientes
where 
	fk_id_unidades_mac is null
;

*/

-- Relacionamento de ref_anticoncep com horus.dispensa_medicamentos

ALTER TABLE horus.dispensa_medicamentos
ADD COLUMN fk_id_ref_anticoncep INTEGER
;

UPDATE horus.dispensa_medicamentos dismed
SET fk_id_ref_anticoncep = id_ref_anticoncep
FROM horus.ref_anticoncep ref 
WHERE ref.codigo_produto = dismed.codigo_produto
;

ALTER TABLE horus.dispensa_medicamentos
ADD CONSTRAINT fk_id_ref_anticoncep FOREIGN KEY (fk_id_ref_anticoncep) REFERENCES horus.ref_anticoncep(id_ref_anticoncep)
;

-- Relacionamento de ref_anticoncep com horus.historico_pacientes

ALTER TABLE horus.historico_pacientes
ADD COLUMN fk_id_ref_anticoncep INTEGER
;

UPDATE horus.historico_pacientes his
SET fk_id_ref_anticoncep = id_ref_anticoncep
FROM horus.ref_anticoncep ref 
WHERE ref.codigo_produto = his.codigo_produto
;

ALTER TABLE horus.historico_pacientes
ADD CONSTRAINT fk_id_ref_anticoncep FOREIGN KEY (fk_id_ref_anticoncep) REFERENCES horus.ref_anticoncep(id_ref_anticoncep)
;

-- REL HISTORICO_PACIENTES COM CALENDARIO

ALTER TABLE horus.historico_pacientes
ADD COLUMN fk_id_calendario_historico_pacientes INTEGER
;

UPDATE horus.historico_pacientes his
SET fk_id_calendario_historico_pacientes = id_calendario 
FROM calendario.calendario calend
WHERE his.data_saida = calend.data_dma
;

ALTER TABLE horus.historico_pacientes
ADD CONSTRAINT fk_id_calendario_historico_pacientes FOREIGN KEY (fk_id_calendario_historico_pacientes) REFERENCES calendario.calendario(id_calendario)
;