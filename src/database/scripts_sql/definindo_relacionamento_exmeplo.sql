
-- Relacionametno de dcbo com dport157

-- foi preciso alterar o tipo da coluna cbo de d157 porque nessa tabela cbo é tipo texto e na tabela dcbo é tipo integer
-- com isso, não é possível 

ALTER TABLE producao.dport157
ALTER COLUMN cbo TYPE VARCHAR(255);

ALTER TABLE producao.dport157 
ADD COLUMN fk_id_dcbo INTEGER;


UPDATE producao.dport157 d157
SET fk_id_dcbo = dcbo.id_dcbo
FROM producao.dcbo dcbo
WHERE d157.cbo = dcbo.cbo;

SELECT id_dport157, cbo, especialidade, procedimentos, fk_id_dcbo 
FROM producao.dport157;

-- Definir o que fazer os nulls (Existem em dport157 mas não existem em dcbo)

ALTER TABLE producao.dport157
ADD CONSTRAINT fk_dcbo FOREIGN KEY (fk_id_dcbo) REFERENCES producao.dcbo (id_dcbo);


select 
	*
from
	producao.dcbo cbo
join 
	producao.dport157 d157
on 
	cbo.id_dcbo = d157.id_dcbo;


-- Definir relacionamento de dcbo com fproducao2024

ALTER TABLE producao.fproducao2024;
DROP COLUMN geometry;


ALTER TABLE producao.fproducao2024
ADD COLUMN fk_id_dcbo INTEGER;

UPDATE producao.fproducao2024 fprod 
SET fk_id_dcbo = dcbo.id_dcbo
FROM producao.dcbo dcbo
WHERE fprod.pa_cbocod = dcbo.cbo; 



ALTER TABLE producao.fproducao2024
ADD CONSTRAINT fk_cbo FOREIGN KEY (fk_id_dcbo) REFERENCES producao.dcbo (id_dcbo);


-- o CBO abaixo não existe na tabela dcbo. Averiguar se há mais
SELECT * FROM producao.dcbo WHERE cbo = '223415';


