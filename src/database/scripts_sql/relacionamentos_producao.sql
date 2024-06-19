
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

ALTER TABLE producao.fproducao2024
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



-- Definindo relacionamentos de dcbo com fprofissionais

ALTER TABLE producao.fprofissionais
ADD COLUMN fk_id_dcbo INTEGER;

UPDATE producao.fprofissionais fprof 
SET fk_id_dcbo = dcbo.id_dcbo
FROM producao.dcbo dcbo
WHERE fprof.cbo = dcbo.cbo;

ALTER TABLE producao.fprofissionais
ADD CONSTRAINT fk_id_dcbo FOREIGN KEY (fk_id_dcbo) REFERENCES producao.dcbo (id_dcbo);

-- aparentemente muitos CBOs que existem em fprofissionais não existem em dcbo

-- COUNT DISTINCT de cbo de fprofissionais é 181. O count distinct de cbo de dcbo é 96

select 
	*
from 
	producao.dcbo as dcbo
right join 
	producao.fprofissionais as fprof
on dcbo.id_dcbo = fprof.fk_id_dcbo
where dcbo.cbo IS NULL
;

--select cbo from producao.dcbo where cbo LIKE '%322245%';


-- Difinindo relacionamento de dformaorganiz com fproducao2024

ALTER TABLE producao.fproducao2024
ADD COLUMN fk_id_dformaorganiz INTEGER;

UPDATE producao.fproducao2024 fprod 
SET fk_id_dformaorganiz = dforg.id_dformaorganiz 
FROM producao.dformaorganiz dforg 
WHERE LEFT(CAST(fprod.pa_proc_id AS TEXT), LENGTH(CAST(fprod.pa_proc_id AS TEXT)) - 4)::INTEGER = dforg.forma_org;

ALTER TABLE producao.fproducao2024
ADD CONSTRAINT fk_id_dformaorganiz FOREIGN KEY (fk_id_dformaorganiz) REFERENCES producao.dformaorganiz(id_dformaorganiz);



-- possível solução para atualizar a coluna fk_id_dcbo

CREATE OR REPLACE FUNCTION update_fk_id_dcbo()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE producao.dport157
    SET fk_id_dcbo = NEW.id_dcbo
    WHERE cbo = NEW.cbo;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_fk_id_dcbo
AFTER INSERT ON producao.dcbo
FOR EACH ROW
EXECUTE FUNCTION update_fk_id_dcbo();


-- solução mais automatizada para atualizar a coluna fk_id_dcbo em todas as tabelas em que essa coluna estiver.

CREATE OR REPLACE FUNCTION update_fk_id_dcbo_all_tables()
RETURNS TRIGGER AS $$
DECLARE
    rec RECORD;
    sql TEXT;
BEGIN
    -- Loop through each table that contains fk_id_dcbo
    FOR rec IN 
        SELECT table_name 
        FROM information_schema.columns 
        WHERE column_name = 'fk_id_dcbo' AND table_schema = 'producao'
    LOOP
        -- Build the dynamic SQL to update the table
        sql := 'UPDATE producao.' || rec.table_name || ' SET fk_id_dcbo = $1 WHERE cbo = $2';
        EXECUTE sql USING NEW.id_dcbo, NEW.cbo;
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_update_fk_id_dcbo_all_tables
AFTER INSERT ON producao.dcbo
FOR EACH ROW
EXECUTE FUNCTION update_fk_id_dcbo_all_tables();
