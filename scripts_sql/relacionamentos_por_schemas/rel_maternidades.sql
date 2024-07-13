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

-- Convertendo dados da coluna mat_classificacao

ALTER TABLE maternidades.mat_classificacao ADD COLUMN data_new DATE;
UPDATE maternidades.mat_classificacao
SET data_new = TO_DATE('1899-12-30', 'YYYY-MM-DD') + (data::integer)
;

ALTER TABLE maternidades.mat_classificacao DROP COLUMN data
;

-- Relacionamento de mat_classificacao com Calendario

ALTER TABLE maternidades.mat_classificacao
ADD COLUMN fk_id_calendario_mat_classificacao INTEGER
;

UPDATE maternidades.mat_classificacao mat_class 
SET fk_id_calendario_mat_classificacao = calend.id_calendario 
FROM calendario.calendario calend
WHERE mat_class.data_new = calend.data_dma
;


ALTER TABLE maternidades.mat_classificacao
ADD CONSTRAINT fk_id_calendario_mat_classificacao FOREIGN KEY (fk_id_calendario_mat_classificacao) REFERENCES calendario.calendario(id_calendario)
;


-- Dropando colunas da tabela mat_leitos

ALTER TABLE maternidades.mat_leitos
DROP COLUMN setor;

-- Convertendo dados da coluna mat_leitos

ALTER TABLE maternidades.mat_leitos
ALTER COLUMN data TYPE date USING data::date
;



DO $$
DECLARE
    col_name TEXT;
    cols TEXT[] := ARRAY[
        'ac_leitoscnes', 'ac_pct_internados', 'ac_no_de_altas', 'ac_no_de_evasao', 
        'ac_no_de_transf_externa', 'ac_no_de_obito', 'ema_pct_internados', 
        'ema_leitoscnes', 'ema_leitos_op', 'ema_no_de_altas', 'ema_no_de_evasao', 
        'ema_no_de_transf_externa', 'pp_pct_internados', 'pp_no_de_altas', 
        'pp_no_de_evasao', 'pp_no_de_transf_externa', 'pp_no_de_obito', 
        'cpn_pct_internados', 'cpn_leitos__cnes', 'cpn_leitos_op', 'cpn_no_de_altas', 
        'cpn_no_de_evasao', 'cpn_no_de_transf_externa', 'cpn_no_de_obito', 
        'berc__pct_internados', 'berc_leitos_op', 'berc__no_de_altas', 
        'berc__no_de_evasao', 'berc__no_de_transf_externa'
    ];
BEGIN
    FOREACH col_name IN ARRAY cols
    LOOP
        EXECUTE format('ALTER TABLE maternidades.mat_leitos ALTER COLUMN %I TYPE INTEGER USING CAST(%I AS INTEGER)', col_name, col_name);
    END LOOP;
END $$;

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


-- Criando relacionamento de mat_leitos e calendario

ALTER TABLE maternidades.mat_leitos
ADD COLUMN fk_id_calendario_mat_leitos INTEGER
;

UPDATE maternidades.mat_leitos leitos 
SET fk_id_calendario_mat_leitos = calend.id_calendario 
FROM calendario.calendario calend
WHERE leitos.data = calend.data_dma
;


ALTER TABLE maternidades.mat_leitos
ADD CONSTRAINT fk_id_calendario_mat_leitos FOREIGN KEY (fk_id_calendario_mat_leitos) REFERENCES calendario.calendario(id_calendario)
;

-- Dropando colunas de mat_procedi_atend

ALTER TABLE maternidades.mat_procedi_atend
DROP COLUMN procedimentos;

-- Convertendo tipos de colunas de mat_procedi_atend

DO $$
DECLARE
    col_name TEXT;
    cols TEXT[] := ARRAY[
        'nascido_vivo', 'bcg', 'teste_da_orelhinha', 'teste_do_olhinho', 
        'teste_do_coracaozinho', 'teste_do_pezinho', 'servico_social', 
        'teste_da_linguinha'
    ];
BEGIN
    FOREACH col_name IN ARRAY cols
    LOOP
        EXECUTE format('ALTER TABLE maternidades.mat_procedi_atend ALTER COLUMN %I TYPE INTEGER USING CAST(%I AS INTEGER)', col_name, col_name);
    END LOOP;
END $$;


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


-- Criando relacionamentos de mat_procedi_atend e calendario

-- Tratar coluna data primeiro

ALTER TABLE maternidades.mat_procedi_atend ADD COLUMN data_new DATE;
UPDATE maternidades.mat_procedi_atend
SET data_new = TO_DATE('1899-12-30', 'YYYY-MM-DD') + (data::integer)
;

ALTER TABLE maternidades.mat_procedi_atend DROP COLUMN data
;

-- Aqui começa a definição do relacionamento

ALTER TABLE maternidades.mat_procedi_atend
ADD COLUMN fk_id_calendario_mat_procedi_atend INTEGER
;

UPDATE maternidades.mat_procedi_atend proced 
SET fk_id_calendario_mat_procedi_atend = calend.id_calendario 
FROM calendario.calendario calend
WHERE proced.data_new = calend.data_dma
;


ALTER TABLE maternidades.mat_procedi_atend
ADD CONSTRAINT fk_id_calendario_mat_procedi_atend FOREIGN KEY (fk_id_calendario_mat_procedi_atend) REFERENCES calendario.calendario(id_calendario)
;


-- Dropando colunas de mat_triagem

ALTER TABLE maternidades.mat_triagem
DROP COLUMN maternidade;

-- Convertendo tipos de colunas de mat_triagem

DO $$
DECLARE
    col_name TEXT;
    cols TEXT[] := ARRAY[
        'parto_normal_cpn', 'parto_normal_cob', 'parto_forceps', 'parto_cesarea', 
        'curetagem', 'diu', 'transferencias', 
        'altas', 'episiotomia', 'evasao'
    ];
BEGIN
    FOREACH col_name IN ARRAY cols
    LOOP
        EXECUTE format('ALTER TABLE maternidades.mat_triagem ALTER COLUMN %I TYPE INTEGER USING CAST(%I AS INTEGER)', col_name, col_name);
    END LOOP;
END $$;

-- -- Definindo relacionametnos das tabelas de mat_triagem com unidades_mac


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

-- Dropando colunas de municipiosdeorigem

ALTER TABLE maternidades.municipiosdeorigem
DROP COLUMN maternidade;

-- Convertendo tipos de colunas de mat_triagem

DO $$
DECLARE
    col_name TEXT;
    cols TEXT[] := ARRAY[
        'recife', 'abreu_e_lima', 'cabo_de_santo_agostinho', 'camaragibe', 
        'igarassu', 'jaboatao_dos_guararapes', 'olinda', 
        'paulista', 'outros'
    ];
BEGIN
    FOREACH col_name IN ARRAY cols
    LOOP
        EXECUTE format('ALTER TABLE maternidades.municipiosdeorigem ALTER COLUMN %I TYPE INTEGER USING CAST(%I AS INTEGER)', col_name, col_name);
    END LOOP;
END $$;

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


