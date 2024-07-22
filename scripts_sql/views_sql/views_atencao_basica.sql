CREATE VIEW atbasica.vw_total_gestante_por_qtd_consulta_prenatal AS
WITH total_consultas_por_gestante AS (
    SELECT 
        gestante_id,
        COUNT(*) AS total_consultas
    FROM 
        atbasica.consulta_prenatal
    GROUP BY 
        gestante_id
)
SELECT 
    total_consultas,
    COUNT(gestante_id) AS numero_de_gestantes
FROM 
    total_consultas_por_gestante
GROUP BY 
    total_consultas
ORDER BY 
    total_consultas
;


CREATE VIEW atbasica.vw_qtd_consultas_prenatal_por_gestante_por_mes_ano AS
SELECT 
    gestante_id,
    COUNT(*) AS numero_de_consultas,
	EXTRACT(MONTH FROM co_dim_tempo) as mes,
	EXTRACT(YEAR FROM co_dim_tempo) as ano
FROM 
    atbasica.consulta_prenatal
GROUP BY 
	1,3,4
ORDER BY 
    4 
;

-- vw_gestantes_consultas_ano
CREATE VIEW atbasica.vw_gestantes_consultas_prenatal_ano AS
WITH total_consultas_por_gestante AS (
    SELECT 
        gestante_id,
        co_dim_tempo_ano,
        COUNT(*) AS total_consultas
    FROM 
        atbasica.consulta_prenatal
    GROUP BY 
        gestante_id, co_dim_tempo_ano
)
SELECT 
    co_dim_tempo_ano AS ano,
    CASE 
        WHEN total_consultas > 6 THEN 'Mais de 6 Consultas'
        ELSE 'Menos de 6 Consultas'
    END AS categoria,
    COUNT(gestante_id) AS numero_de_gestantes
FROM 
    total_consultas_por_gestante
GROUP BY 
    co_dim_tempo_ano,
    CASE 
        WHEN total_consultas > 6 THEN 'Mais de 6 Consultas'
        ELSE 'Menos de 6 Consultas'
    END
ORDER BY 
    co_dim_tempo_ano, categoria
;



-- analises 
/*
select count(*) from atbasica.consulta_prenatal where co_dim_tempo_dum IS NULL

select count(*) from atbasica.consulta_prenatal where dpp_valido = true



-- quantidade de total de consultas por gestantes

SELECT 
    gestante_id,
    COUNT(*) AS numero_de_consultas
FROM 
    atbasica.consulta_prenatal
GROUP BY 
    gestante_id
ORDER BY 
    numero_de_consultas DESC
;

-- relatorio com total geral de consultas e por gestante
SELECT 
    gestante_id,
    COUNT(*) AS numero_de_consultas
FROM 
    atbasica.consulta_prenatal
GROUP BY 
    CUBE(gestante_id)
ORDER BY 
    numero_de_consultas DESC
;

-- relatorio com total de consultas por gestante por co_dim_tempo
SELECT 
    gestante_id,
    COUNT(*) AS numero_de_consultas,
	co_dim_tempo
FROM 
    atbasica.consulta_prenatal
GROUP BY 
    gestante_id, co_dim_tempo
ORDER BY 
    numero_de_consultas DESC
;


-- media de consultas por gestante por e mes e por ano

SELECT 
    ano,
    mes,
    AVG(total_consultas) AS media_consultas
FROM (
    SELECT 
        gestante_id,
        EXTRACT(YEAR FROM co_dim_tempo) AS ano,
        EXTRACT(MONTH FROM co_dim_tempo) AS mes,
        COUNT(*) AS total_consultas
    FROM 
        atbasica.consulta_prenatal
    GROUP BY 
        gestante_id, EXTRACT(YEAR FROM co_dim_tempo), EXTRACT(MONTH FROM co_dim_tempo)
) AS subquery
GROUP BY 
    ano, mes
ORDER BY 
    ano, mes
;


-- Total de gestante por quantidade de consultas realizadas 
WITH total_consultas_por_gestante AS (
    SELECT 
        gestante_id,
        COUNT(*) AS total_consultas
    FROM 
        atbasica.consulta_prenatal
    GROUP BY 
        gestante_id
)
SELECT 
    total_consultas,
    COUNT(gestante_id) AS numero_de_gestantes
FROM 
    total_consultas_por_gestante
GROUP BY 
    total_consultas
ORDER BY 
    total_consultas
;

*/