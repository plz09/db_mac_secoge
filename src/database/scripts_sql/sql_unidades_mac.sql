-- codigo para criar e popular tabela unidades_mac

CREATE TABLE IF NOT EXISTS unidades.unidades_mac (
		id_unidades_mac Integer,
        cnes_padrao INTEGER,
        codigo_unidade INTEGER,
        distrito INTEGER,
        nome CHARACTER VARYING,
        tipo_servi CHARACTER VARYING
    );

INSERT INTO unidades.unidades_mac (id_unidades_mac, cnes_padrao, codigo_unidade, distrito, nome, tipo_servi)
SELECT id_unidades, cnes_padrao, no_da_us, ds, nome_fantasia, tipo_servi
FROM unidades.unidades;


select * from unidades.unidades_mac;

  

 










