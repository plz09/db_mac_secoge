-- Alterando tipo de data na coluna Data da tabela horus_dispensa_medicamento

ALTER TABLE horus.dispensa_medicamentos
ALTER COLUMN data TYPE date USING data::date
;


ALTER TABLE horus.dispensa_medicamentos
ADD COLUMN fk_id_unidades_mac INTEGER
;




