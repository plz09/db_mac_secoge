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
    mvm VARCHAR(6)
);

DO $$ 
DECLARE
    dia DATE;
    nome_dia_pt VARCHAR(20);
    mes_abreviado_pt VARCHAR(3);
    mes_completo_pt VARCHAR(20);
BEGIN
    FOR dia IN 
        SELECT generate_series('2010-01-01'::date, '2025-12-31'::date, '1 day') AS Date
    LOOP
        -- Traduzir nome do dia para português
        nome_dia_pt := CASE EXTRACT(DOW FROM dia)
            WHEN 0 THEN 'Domingo'
            WHEN 1 THEN 'Segunda-feira'
            WHEN 2 THEN 'Terça-feira'
            WHEN 3 THEN 'Quarta-feira'
            WHEN 4 THEN 'Quinta-feira'
            WHEN 5 THEN 'Sexta-feira'
            WHEN 6 THEN 'Sábado'
        END;

        -- Traduzir mês abreviado para português
        mes_abreviado_pt := CASE EXTRACT(MONTH FROM dia)
            WHEN 1 THEN 'Jan'
            WHEN 2 THEN 'Fev'
            WHEN 3 THEN 'Mar'
            WHEN 4 THEN 'Abr'
            WHEN 5 THEN 'Mai'
            WHEN 6 THEN 'Jun'
            WHEN 7 THEN 'Jul'
            WHEN 8 THEN 'Ago'
            WHEN 9 THEN 'Set'
            WHEN 10 THEN 'Out'
            WHEN 11 THEN 'Nov'
            WHEN 12 THEN 'Dez'
        END;

        -- Traduzir mês completo para português
        mes_completo_pt := CASE EXTRACT(MONTH FROM dia)
            WHEN 1 THEN 'Janeiro'
            WHEN 2 THEN 'Fevereiro'
            WHEN 3 THEN 'Março'
            WHEN 4 THEN 'Abril'
            WHEN 5 THEN 'Maio'
            WHEN 6 THEN 'Junho'
            WHEN 7 THEN 'Julho'
            WHEN 8 THEN 'Agosto'
            WHEN 9 THEN 'Setembro'
            WHEN 10 THEN 'Outubro'
            WHEN 11 THEN 'Novembro'
            WHEN 12 THEN 'Dezembro'
        END;

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
            nome_dia_pt,
            EXTRACT(DOW FROM dia),
            mes_abreviado_pt,
            CASE
                WHEN EXTRACT(MONTH FROM dia) IN (1, 2, 3, 4) THEN 1
                WHEN EXTRACT(MONTH FROM dia) IN (5, 6, 7, 8) THEN 2
                WHEN EXTRACT(MONTH FROM dia) IN (9, 10, 11, 12) THEN 3
            END,
            TO_CHAR(dia, 'YYYY') || '.' || CASE
                WHEN EXTRACT(MONTH FROM dia) IN (1, 2, 3, 4) THEN '1'
                WHEN EXTRACT(MONTH FROM dia) IN (5, 6, 7, 8) THEN '2'
                WHEN EXTRACT(MONTH FROM dia) IN (9, 10, 11, 12) THEN '3'
            END,
            mes_completo_pt,
            TO_CHAR(dia, 'YYYYMM')
        );
    END LOOP;
END $$;


-- Criando tabela ano_mes_cadastro para relacionamento com mae_coruja 

ALTER TABLE calendario.calendario ADD COLUMN ano_mes CHAR(7);
UPDATE calendario.calendario
SET ano_mes = TO_CHAR(data_dma, 'YYYY-MM');