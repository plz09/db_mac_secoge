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



*/