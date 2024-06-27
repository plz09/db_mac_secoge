-- Definindo relacionametnos das tabelas de mae_coruja com ds_unidades.distritos

-- Rel de mae_coruja.espacos com ds_unidades.distritos

ALTER TABLE mae_coruja.espacos
ADD COLUMN fk_id_distritos INTEGER
;

UPDATE mae_coruja.espacos mae_co_espacos 
SET fk_id_distritos = ds.id_distritos 
FROM ds_unidades.distritos ds 
WHERE REPLACE(mae_co_espacos.ds, ' ', '') = ds.ds_romano 
   OR REPLACE(mae_co_espacos.ds, '7 DSs', 'VII') = ds.ds_romano
;

ALTER TABLE mae_coruja.espacos
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;

-- Relacionamento de mae_coruja.espacos_bairros_cobertos com ds_unidades.distritos

ALTER TABLE mae_coruja.espacos_bairros_cobertos
ADD COLUMN fk_id_distritos INTEGER
;

UPDATE mae_coruja.espacos_bairros_cobertos mae_co_espac_cobertos 
SET fk_id_distritos = ds.id_distritos 
FROM ds_unidades.distritos ds 
WHERE REPLACE(mae_co_espac_cobertos.ds, ' ', '') = ds.ds_romano 
;

ALTER TABLE mae_coruja.espacos_bairros_cobertos
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;

-- Relacionamento espacos_unidades com unidades_mac


ALTER TABLE mae_coruja.espacos_unidades
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE mae_coruja.espacos_unidades espac_uni 
SET fk_id_unidades_mac = tab_mac.id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac 
WHERE espac_uni.usf_cnes = tab_mac.cnes_padrao 
;

ALTER TABLE mae_coruja.espacos_unidades
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;

-- Dropando colunas da tabela mae_coruja_atividades

DO $$
DECLARE
    column_name text;
    columns_to_keep text[] := array[
        'id_atividades', 'no', 'secretaria', 'espaco', 'acao', 'data_inicio', 
        'data_termino', 'presentes', 'convidados', 'observacao', 
        'sintese_da_acao', 'equipe_tecnica'
    ];
    drop_columns_query text := 'ALTER TABLE mae_coruja.atividades ';
BEGIN
    FOR column_name IN 
        SELECT col.column_name
        FROM information_schema.columns col
        WHERE col.table_name = 'atividades' 
        AND col.table_schema = 'mae_coruja'
        AND col.column_name <> ALL(columns_to_keep)
    LOOP
        drop_columns_query := drop_columns_query || 'DROP COLUMN "' || column_name || '", ';
    END LOOP;

    -- Remove the última vírgula e espaço
    drop_columns_query := left(drop_columns_query, length(drop_columns_query) - 2) || ';';

    -- Execute a query dinâmica
    EXECUTE drop_columns_query;
END $$;


-- Relacionamento de mae_coruja_atividades com mae_coruja.espacos

ALTER TABLE mae_coruja.atividades
ADD COLUMN fk_id_espacos INTEGER
;

UPDATE mae_coruja.atividades mae_co_ativd 
SET fk_id_espacos = mae_co_espacos.id_espacos
FROM mae_coruja.espacos mae_co_espacos  
WHERE mae_co_ativd.espaco LIKE CONCAT('%', mae_co_espacos.espaco, '%')
;

ALTER TABLE mae_coruja.atividades
ADD CONSTRAINT fk_id_espacos FOREIGN KEY (fk_id_espacos) REFERENCES mae_coruja.espacos(id_espacos)
;

-- Relacionamento de mae_coruja_kits com distritos

ALTER TABLE mae_coruja.kits
ADD COLUMN fk_id_distritos INTEGER
;


UPDATE mae_coruja.kits kits 
SET fk_id_distritos = (
    SELECT ds.id_distritos
    FROM ds_unidades.distritos ds
    WHERE ds.distrito_sanitario = LEFT(kits.espaco_mae_coruja, 7)
)
WHERE EXISTS (
    SELECT 1
    FROM ds_unidades.distritos ds
    WHERE ds.distrito_sanitario = LEFT(kits.espaco_mae_coruja, 7)
);



ALTER TABLE mae_coruja.kits
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;

-- Relacionamento de mae_coruja_mulher com distritos

-- Inserindo coluna ds na tabela mae coruja mulher para trazer chave estrangeira de distritos

ALTER TABLE mae_coruja.mulher
ADD COLUMN ds VARCHAR
;

UPDATE mae_coruja.mulher
SET ds = 
    SUBSTRING(
        canto,
        POSITION(' - ' IN canto) + 3,
        POSITION(' - ' IN SUBSTRING(canto FROM POSITION(' - ' IN canto) + 3)) - 1
    );


UPDATE mae_coruja.mulher mulher 
SET ds = REPLACE(mulher.ds, 'Distrito', 'DS')
;

-- Inserindo coluna fd_id_distritos em mae_coruja_mulher

ALTER TABLE mae_coruja.mulher
ADD COLUMN fk_id_distritos INTEGER
;

UPDATE mae_coruja.mulher mulher 
SET fk_id_distritos = tab_ds.id_distritos
FROM ds_unidades.distritos tab_ds  
WHERE mulher.ds = tab_ds.distrito_sanitario
;


ALTER TABLE mae_coruja.mulher
ADD CONSTRAINT fk_id_distritos FOREIGN KEY (fk_id_distritos) REFERENCES ds_unidades.distritos(id_distritos)
;