
-- foi preciso alterar o tipo da coluna cbo de d157 porque nessa tabela cbo é tipo texto e na tabela dcbo é tipo integer
-- com isso, não é possível 

ALTER TABLE producao.dport157
ALTER COLUMN cbo TYPE VARCHAR(255);

ALTER TABLE producao.dport157 
ADD COLUMN id_dcbo INTEGER;


UPDATE producao.dport157 d157
SET id_dcbo = dcbo.id_dcbo
FROM producao.dcbo dcbo
WHERE d157.cbo = dcbo.cbo;

SELECT id_dport157, cbo, especialidade, procedimentos, id_dcbo 
FROM producao.dport157;

select * from producao.dcbo where cbo = '223117';

ALTER TABLE producao.dport157
ADD CONSTRAINT fk_dcbo FOREIGN KEY (id_dcbo) REFERENCES producao.dcbo (id_dcbo);


select 
	*
from
	producao.dcbo cbo
join 
	producao.dport157 d157
on 
	cbo.id_dcbo = d157.id_dcbo;
