CREATE TABLE calendario.calendario (
    id_calendario SERIAL PRIMARY KEY,
    data_dma DATE,
    ano INTEGER,
    mes INTEGER,
    dia INTEGER,
    nome_dia VARCHAR(20),
    dia_semana INTEGER,
    mes_abreviado VARCHAR(3),
    quadrimestre INTEGER,
    ano_quadrimestre VARCHAR(7),
    mes_completo VARCHAR(20),
    mvm INTEGER
);

DO $$ 
DECLARE
    dia DATE;
BEGIN
    FOR dia IN 
        SELECT generate_series('2015-01-01'::date, '2025-12-31'::date, '1 day') AS Date
    LOOP
        INSERT INTO calendario.calendario (
            data_dma,
            ano,
            mes,
            dia,
            nome_dia,
            dia_semana,
            mes_abreviado,
            quadrimestre,
            ano_quadrimestre,
            mes_completo,
            mvm
        ) VALUES (
            dia,
            EXTRACT(YEAR FROM dia),
            EXTRACT(MONTH FROM dia),
            EXTRACT(DAY FROM dia),
            TO_CHAR(dia, 'FMDay'),
            EXTRACT(DOW FROM dia),
            TO_CHAR(dia, 'Mon'),
            CASE
                WHEN EXTRACT(MONTH FROM dia) IN (1, 2, 3) THEN 1
                WHEN EXTRACT(MONTH FROM dia) IN (4, 5, 6) THEN 2
                WHEN EXTRACT(MONTH FROM dia) IN (7, 8, 9) THEN 3
                WHEN EXTRACT(MONTH FROM dia) IN (10, 11, 12) THEN 4
            END,
            TO_CHAR(dia, 'YYYY') || '-Q' || CASE
                WHEN EXTRACT(MONTH FROM dia) IN (1, 2, 3) THEN '1'
                WHEN EXTRACT(MONTH FROM dia) IN (4, 5, 6) THEN '2'
                WHEN EXTRACT(MONTH FROM dia) IN (7, 8, 9) THEN '3'
                WHEN EXTRACT(MONTH FROM dia) IN (10, 11, 12) THEN '4'
            END,
            TO_CHAR(dia, 'FMMonth YYYY'),
            TO_NUMBER(TO_CHAR(dia, 'YYYYMM'), '999999')
        );
    END LOOP;
END $$;

-- Criando tabela ano_mes_cadastro para relacionamento com mae_coruja 

ALTER TABLE calendario.calendario ADD COLUMN ano_mes CHAR(7);
UPDATE calendario.calendario
SET ano_mes = TO_CHAR(data_dma, 'YYYY-MM');
