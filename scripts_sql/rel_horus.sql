-- Alterando tipo de data na coluna Data da tabela horus_dispensa_medicamento

ALTER TABLE horus.horus_dispensa_medicamentos
ALTER COLUMN data TYPE date USING Data::date
;





