CREATE VIEW mae_coruja.vw_mae_coruja_envios_por_mes AS
WITH mes_mapping AS (
    SELECT 1 AS mes, 'Janeiro' AS mes_nome
    UNION ALL SELECT 2, 'Fevereiro'
    UNION ALL SELECT 3, 'Março'
    UNION ALL SELECT 4, 'Abril'
    UNION ALL SELECT 5, 'Maio'
    UNION ALL SELECT 6, 'Junho'
    UNION ALL SELECT 7, 'Julho'
    UNION ALL SELECT 8, 'Agosto'
    UNION ALL SELECT 9, 'Setembro'
    UNION ALL SELECT 10, 'Outubro'
    UNION ALL SELECT 11, 'Novembro'
    UNION ALL SELECT 12, 'Dezembro'
)
SELECT k.mes_envio AS mes,
       k.data_de_envio, 
       m.mes_nome,
       k.espaco_mae_coruja,
       k.quantidade_envios
FROM (
    SELECT mes_envio,
           data_de_envio, 
           espaco_mae_coruja,
           count(*) AS quantidade_envios
    FROM mae_coruja.kits
    GROUP BY mes_envio, espaco_mae_coruja, data_de_envio
) k
JOIN mes_mapping m ON k.mes_envio = m.mes
ORDER BY k.mes_envio
;