-- Deletando colunas desnecessarias

CREATE OR REPLACE FUNCTION obras.delete_columns_obras_except(p_table_name text, columns_to_keep text[]) RETURNS void AS $$
DECLARE
    col_list text;
BEGIN
    -- Exibir nome da tabela e colunas a serem mantidas para depuração
    RAISE NOTICE 'Tabela: %', p_table_name;
    RAISE NOTICE 'Colunas a serem mantidas: %', array_to_string(columns_to_keep, ', ');

    -- Construir uma lista de todas as colunas da tabela, exceto as que queremos manter
    SELECT string_agg('DROP COLUMN ' || quote_ident(c.column_name), ', ')
    INTO col_list
    FROM information_schema.columns c
    WHERE c.table_name = p_table_name
    AND c.column_name <> ALL(columns_to_keep)
    AND c.table_schema = 'obras';

    -- Exibir a lista de colunas a serem deletadas para depuração
    RAISE NOTICE 'Colunas a serem deletadas: %', col_list;

    -- Verificar se há colunas para deletar
    IF col_list IS NOT NULL THEN
        -- Construir e executar o comando ALTER TABLE para deletar colunas
        EXECUTE 'ALTER TABLE obras.' || quote_ident(p_table_name) || ' ' || col_list;
    ELSE
        RAISE NOTICE 'Nenhuma coluna a ser deletada.';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT obras.delete_columns_obras_except(
    'obras',
    ARRAY[
        'nivel',
        'perfil',
        'cnes',
        'unidades',
        'fase',
        'tipo_intervencao',
        'escopo_resumido',
        'inicio_previsto',
        'termino_previsto',
        '%_exe',
        'observacao',
        'status',
        'termino_pactuado'
    ]
);



-- Crianco relacionamento com unidades_mac

-- Tratando coluna cnes primeiro

UPDATE obras.obras
SET cnes = NULLIF(cnes, '-')
;

ALTER TABLE obras.obras
ALTER COLUMN cnes TYPE INTEGER USING cnes::INTEGER
;


ALTER TABLE obras.obras
ADD COLUMN fk_id_unidades_mac INTEGER
;

UPDATE obras.obras obras
SET fk_id_unidades_mac = id_unidades_mac
FROM ds_unidades.unidades_mac tab_mac
WHERE tab_mac.cnes_padrao = obras.cnes
;

ALTER TABLE obras.obras 
ADD CONSTRAINT fk_id_unidades_mac FOREIGN KEY (fk_id_unidades_mac) REFERENCES ds_unidades.unidades_mac(id_unidades_mac)
;