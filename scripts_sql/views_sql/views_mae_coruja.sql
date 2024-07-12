CREATE VIEW mae_coruja.envios_por_mes AS
SELECT
    mes_envio AS mes,
	espaco_mae_coruja,
    COUNT(*) AS quantidade_envios
FROM
    mae_coruja.kits
GROUP BY
    mes, espaco_mae_coruja
ORDER BY
    mes;
